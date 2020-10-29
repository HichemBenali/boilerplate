import '../core/model.dart';

abstract class Provider {
  // Load Model from network.
  Future<bool> load();

  // get cached records.
  Future<List<Model>> get();

  // Saves [model] to database and api.
  Future<bool> create(Model model);

  // Updates [model] in database and api.
  Future<bool> update(Model model);

  // Deletes [model] from database and api.
  Future<bool> delete(Model model);

  // Searches [name] from database.
  Future<List<Model>> search(String name);
}
