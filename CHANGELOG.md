## 0.1.0

* Decode every verb in one place, and run `transformer` before the object-or-list check so nested payloads such as `{"data": [...]}` map correctly.
* Treat any 2xx status as success unless `successCodes` is set. Empty bodies return null, or an empty list from the list methods.
* `successCodes` outside the normal 2xx range are accepted when no custom `validateStatus` is set.
* Pass an existing `Dio` or `BaseOptions` for a base URL, headers, and timeouts.
* `url` is required. Failed requests and unexpected JSON shapes throw `SimpleError`.
* Support Flutter 3.3 through current Flutter 3.x (Dart `>=2.18.0 <4.0.0`), including Linux and Windows.

## 0.0.6

Lowered sdk bundle contraints

## 0.0.5

Fixed wrong link to repo

## 0.0.4

* Updated docs
## 0.0.3

* Updated docs

## 0.0.2

* Updated target platforms.

## 0.0.1

* TODO: Describe initial release.
