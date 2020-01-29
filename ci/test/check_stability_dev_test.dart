import 'package:ci/domain/config.dart';
import 'package:ci/domain/element.dart';
import 'package:ci/exceptions/exceptions.dart';
import 'package:ci/tasks/check_stability_dev.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'core/test_helper.dart';

void main() {
  test(
    'Unstable element should not be affected',
    () async {
      var elements = <Element>[
        createTestElement(),
        createTestElement(),
        createTestElement(),
        createTestElement(),
      ];
      var pp = PubspecParserMock();

      var check = CheckStabilityDev(elements, pp);

      expect(await check.run(), true);
    },
  );

  test(
    'Stable elements than was not changed should not be affected',
    () async {
      var elements = <Element>[
        createTestElement(isStable: true),
        createTestElement(isStable: true),
        createTestElement(isStable: true),
        createTestElement(isStable: true),
      ];
      var pp = PubspecParserMock();

      var check = CheckStabilityDev(elements, pp);

      expect(await check.run(), true);
    },
  );

  test(
    'New stable elements should throw exception',
    () {
      _testChangeStability(
        <Element>[
          createTestElement(
            name: 'very new module',
            isStable: true,
            isChanged: true,
          ),
          createTestElement(),
        ],
        <Element>[
          createTestElement(),
        ],
        throwsA(
          TypeMatcher<StabilityDevChangedException>(),
        ),
      );
    },
  );

  test(
    'Became stable elements should throw exception',
    () {
      _testChangeStability(
        <Element>[
          createTestElement(
            name: 'became stable module',
            isStable: true,
            isChanged: true,
          ),
        ],
        <Element>[
          createTestElement(
            name: 'became stable module',
            isStable: false,
          ),
        ],
        throwsA(
          TypeMatcher<StabilityDevChangedException>(),
        ),
      );
    },
  );

  test(
    'Stable elements that was stable should not throw exception',
    () {
      _testChangeStability(
        <Element>[
          createTestElement(
            name: 'stable module',
            isStable: true,
            isChanged: true,
          ),
        ],
        <Element>[
          createTestElement(
            name: 'stable module',
            isStable: true,
          ),
        ],
        returnsNormally,
      );
    },
  );

  test(
    'Fail get hash should throw exception',
    () async {
      _gitFailTest(
        <String, dynamic>{
          'git rev-parse HEAD': false,
        },
        throwsA(
          TypeMatcher<CommitHashException>(),
        ),
      );
    },
  );

  test(
    'Fail checkout head should throw exception',
        () async {
      _gitFailTest(
        <String, dynamic>{
          'git rev-parse HEAD': createPositiveResult(stdout: 'testhash'),
          'git checkout HEAD~': false,
        },
        throwsA(
          TypeMatcher<CheckoutException>(),
        ),
      );
    },
  );

  test(
    'Fail checkout hash should throw exception',
        () async {
      _gitFailTest(
        <String, dynamic>{
          'git rev-parse HEAD': createPositiveResult(stdout: 'testhash'),
          'git checkout HEAD~': true,
          'git checkout testhash': false,
        },
        throwsA(
          TypeMatcher<CheckoutException>(),
        ),
      );
    },
  );
}

void _testChangeStability(
  List<Element> newE,
  List<Element> oldE,
  matcher,
) {
  var callingMap = <String, dynamic>{
    'git rev-parse HEAD': createPositiveResult(stdout: 'testhash'),
    'git checkout HEAD~': true,
    'git checkout testhash': true,
  };

  substituteShell(callingMap: callingMap);

  var pp = PubspecParserMock();
  when(pp.parsePubspecs(Config.packagesPath)).thenReturn(oldE);

  var check = CheckStabilityDev(newE, pp);

  expect(
    () async => await check.run(),
    matcher,
  );
}

void _gitFailTest(
  Map<String, dynamic> callingMap,
  matcher,
) {
  var elements = <Element>[
    createTestElement(isStable: true, isChanged: true),
  ];
  var pp = PubspecParserMock();

  substituteShell(callingMap: callingMap);

  var check = CheckStabilityDev(elements, pp);

  expect(
    () async => await check.run(),
    matcher,
  );
}
