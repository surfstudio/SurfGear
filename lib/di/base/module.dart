/// Marker interface.
/// Provide concrete dependency.
///
/// TODO:: think about annotation and provide more dependencies from one module(may be)
abstract class Module<T> {
  T provides();
}