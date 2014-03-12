WTA Generator
=================================
Forked from the awesome android-contentprovider-generator

A tool to generate a Content Provider and the associated ViewModels and Model classes

It takes a set of entity (a.k.a "table") definitions as the input, and generates:
- a `ContentProvider` class
- a `SQLiteOpenHelper` class
- one `BaseColumns` interface per entity 
- one `Cursor` class per entity
- one `ContentValues` class per entity
- one `Selection` class per entity
- one `Model` class per entity
- one `ViewModel` class per entity
- one Layout xml file per ViewModel

How to use
----------

### The `_config.json` file

This is where you declare a few parameters that will be used to generate the code.

These are self-explanatory so here is an example:
```json
{
	"toolVersion": "1.5",
	"projectPackageId": "com.test",
	"authority": "com.test.provider",
	"providerJavaPackage": "com.test.provider",
	"providerClassName": "ExampleProvider",
	"sqliteHelperClassName": "ExampleSQLiteOpenHelper",
	"databaseFileName": "example.db",
	"enableForeignKeys": true,
	"projectBaseUrl": "http://api.example.com",
	"generateProvider":true,
	"generateModels":true,
	"generateViews":true,
	"generateApi":true,
}
```

### Entity files

Create one file per entity, naming it `<entity name>.json`.
Inside each file, declare your fields (a.k.a "columns") with a name and a type.
You can also optionally declare a default value, an index flag and a nullable flag.

Currently the type can be:
- `String` (SQLite type: `TEXT`)
- `Integer` (`INTEGER`)
- `Long` (`INTEGER`)
- `Float` (`REAL`)
- `Double` (`REAL`) 
- `Boolean` (`INTEGER`)
- `Date` (`INTEGER`)
- `byte[]` (`BLOB`)
- `enum` (`INTEGER`).

You can also optionally declare table contraints.

Here is a `person.json` file as an example:

```json
{
	"fields": [
		{
			"name": "first_name",
			"serializedName": "FirstName",
			"type": "String"
		},
		{
			"name": "last_name",
			"type": "String"
		},
		{
			"name": "age",
			"type": "Integer",
			"nullable": false
		},
		{
			"name": "is_blue_eyes",
			"type": "Boolean",
			"default_value": "1"
		},
		{
			"name": "date_of_birth",
			"type": "Date",
			"index": true
		},
		{
			"name": "height",
			"type": "Float"
		},
		{
			"name": "company_id",
			"type": "Long",
			"nullable": false,
		},
        {
         "name": "gender",
         "type": "enum",
         "enumName": "Gender",
         "enumValues": [
             "MALE",
             "FEMALE",
             "OTHER",
         ],
         "nullable": false,
        }
	],

	"constraints": [
		{
			"name": "unique_name",
			"definition": "unique (first_name, last_name) on conflict replace"
		},
		{
			"name": "fk_company",
			"definition": "foreign key (company_id) references company (_id) on delete cascade",
		},
	],

	"urlPath":"/person/{user}/info",
	"queryParams":[
	    {
            "name": "userId",
        },
        {
            "name": "stuff",
        },
	],
}
```

A more comprehensive example is available in the `etc/sample` folder.

### The `header.txt` file (optional)

If a `header.txt` file is present, its contents will be inserted at the top of every generated file.

### Get the app

Download the jar from here:
https://github.com/--insert jar here when it's done--

### Run the app

`java -jar wta-generator-1.5-bundle.jar -i <input folder> -o <output folder>`
- Input folder: where to find _config.json and your entity json files
- Output folder: where the resulting files will be generated

### Use the generated files

- When querying a table, use the corresponding `Selection` class as shown in this example:

```java
PersonSelection where = new PersonSelection();
where.firstName("John").or().age(42);
Cursor c = context.getContentResolver().query(PersonColumns.CONTENT_URI, projection,
        where.sel(), where.args(), null);
```
- When using the results of a query, wrap the resulting `Cursor` in the corresponding wrapper class.  You can then use
the generated getters directly as shown in this example:

```java
PersonCursor person = new PersonCursor(c);
String lastName = person.getLastName();
Long age = person.getAge();
```
- You can also conveniently combine these two facilities by using the `query` (or `delete`) method:

```java
PersonSelection where = new PersonSelection();
where.firstName("John").or().age(42);
PersonCursor person = where.query(getContentResolver());
String lastName = person.getLastName();
Long age = person.getAge();
```
- When updating or inserting into a table, use the corresponding `ContentValues` class as shown in this example:

```java
PersonContentValues values = new PersonContentValues();
values.putFirstName("John").putAge(42);
context.getContentResolver().update(personUri, values.values(), null, null);
```
- When generating the Model Classes, if they are generated with a ContentProvider they come with a handy Constructor which takes a CursorWrapper of that objects type

```java
PersonCursor wrappedCursor = new PersonCursor(cursor);
Person person = new Person(wrappedCursor);
```

- When generated, the API uses a stubbed out Retrofit interface and an IntentService for network calls
- In addition, when generating the API, it also ties into the ContentProvider(if all components were generated)

Building
--------

You need maven to build this app.

`mvn package`

This will produce `wta-generator-1.5-bundle.jar` in the `target` folder.


Licence
-------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

*Just to be absolutely clear, this license applies to this program itself,
not to the source it will generate!*
