import FirebaseFirestore
import FirebaseFirestoreSwift

class Query: ExpressibleByStringLiteral {
    /** The `FIRFirestore` for the Firestore database (useful for performing transactions, etc.). */
    let firestore: Firestore
    let collection: CollectionReference
    var query: FirebaseFirestore.Query
    
    required init(stringLiteral value: String) {
        firestore = Firestore.firestore()
        collection = Firestore.firestore().collection(value)
        query = collection
    }

    /**
     * Reads the documents matching this query.
     *
     * This method attempts to provide up-to-date data when possible by waiting for
     * data from the server, but it may return cached data or fail if you are
     * offline and the server cannot be reached. See the
     * `getDocuments(source:completion:)` method to change this behavior.
     *
     * @param completion a block to execute once the documents have been successfully read.
     *     documentSet will be `nil` only if error is `non-nil`.
     */
    func getDocuments(completion: @escaping FIRQuerySnapshotBlock) {
        query.getDocuments(completion: completion)
    }

    
    /**
     * Reads the documents matching this query.
     *
     * @param source indicates whether the results should be fetched from the cache
     *     only (`Source.cache`), the server only (`Source.server`), or to attempt
     *     the server and fall back to the cache (`Source.default`).
     * @param completion a block to execute once the documents have been successfully read.
     *     documentSet will be `nil` only if error is `non-nil`.
     */
    func getDocuments(source: FirestoreSource, completion: @escaping FIRQuerySnapshotBlock) {
        query.getDocuments(source: source, completion: completion)
    }

    
    /**
     * Attaches a listener for QuerySnapshot events.
     *
     * @param listener The listener to attach.
     *
     * @return A FIRListenerRegistration that can be used to remove this listener.
     */
    func addSnapshotListener(_ listener: @escaping FIRQuerySnapshotBlock) -> ListenerRegistration {
        return query.addSnapshotListener(listener)
    }

    
    /**
     * Attaches a listener for QuerySnapshot events.
     *
     * @param includeMetadataChanges Whether metadata-only changes (i.e. only
     *     `FIRDocumentSnapshot.metadata` changed) should trigger snapshot events.
     * @param listener The listener to attach.
     *
     * @return A FIRListenerRegistration that can be used to remove this listener.
     */
    func addSnapshotListener(includeMetadataChanges: Bool, listener: @escaping FIRQuerySnapshotBlock) -> ListenerRegistration {
        return query.addSnapshotListener(includeMetadataChanges: includeMetadataChanges, listener: listener)
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * contain the specified field and the value must be equal to the specified value.
     *
     * @param field The name of the field to compare.
     * @param value The value the field must be equal to.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ field: String, isEqualTo value: Any) -> Query {
        query = query.whereField(field, isEqualTo: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * contain the specified field and the value must be equal to the specified value.
     *
     * @param path The path of the field to compare.
     * @param value The value the field must be equal to.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ path: FieldPath, isEqualTo value: Any) -> Query {
        query = query.whereField(path, isEqualTo: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * contain the specified field and the value must be less than the specified value.
     *
     * @param field The name of the field to compare.
     * @param value The value the field must be less than.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ field: String, isLessThan value: Any) -> Query {
        query = query.whereField(field, isLessThan: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * contain the specified field and the value must be less than the specified value.
     *
     * @param path The path of the field to compare.
     * @param value The value the field must be less than.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ path: FieldPath, isLessThan value: Any) -> Query {
        query = query.whereField(path, isLessThan: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * contain the specified field and the value must be less than or equal to the specified value.
     *
     * @param field The name of the field to compare
     * @param value The value the field must be less than or equal to.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ field: String, isLessThanOrEqualTo value: Any) -> Query {
        query = query.whereField(field, isLessThanOrEqualTo: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * contain the specified field and the value must be less than or equal to the specified value.
     *
     * @param path The path of the field to compare
     * @param value The value the field must be less than or equal to.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ path: FieldPath, isLessThanOrEqualTo value: Any) -> Query {
        query = query.whereField(path, isLessThanOrEqualTo: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * contain the specified field and the value must greater than the specified value.
     *
     * @param field The name of the field to compare
     * @param value The value the field must be greater than.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ field: String, isGreaterThan value: Any) -> Query {
        query = query.whereField(field, isGreaterThan: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * contain the specified field and the value must greater than the specified value.
     *
     * @param path The path of the field to compare
     * @param value The value the field must be greater than.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ path: FieldPath, isGreaterThan value: Any) -> Query {
        query = query.whereField(path, isGreaterThan: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * contain the specified field and the value must be greater than or equal to the specified value.
     *
     * @param field The name of the field to compare
     * @param value The value the field must be greater than.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ field: String, isGreaterThanOrEqualTo value: Any) -> Query {
        query = query.whereField(field, isGreaterThanOrEqualTo: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * contain the specified field and the value must be greater than or equal to the specified value.
     *
     * @param path The path of the field to compare
     * @param value The value the field must be greater than.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ path: FieldPath, isGreaterThanOrEqualTo value: Any) -> Query {
        query = query.whereField(path, isGreaterThanOrEqualTo: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must contain
     * the specified field, it must be an array, and the array must contain the provided value.
     *
     * A query can have only one arrayContains filter.
     *
     * @param field The name of the field containing an array to search
     * @param value The value that must be contained in the array
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ field: String, arrayContains value: Any) -> Query {
        query = query.whereField(field, arrayContains: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must contain
     * the specified field, it must be an array, and the array must contain the provided value.
     *
     * A query can have only one arrayContains filter.
     *
     * @param path The path of the field containing an array to search
     * @param value The value that must be contained in the array
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ path: FieldPath, arrayContains value: Any) -> Query {
        query = query.whereField(path, arrayContains: value)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must contain
     * the specified field, the value must be an array, and that array must contain at least one value
     * from the provided array.
     *
     * A query can have only one `arrayContainsAny` filter and it cannot be combined with
     * `arrayContains` or `in` filters.
     *
     * @param field The name of the field containing an array to search.
     * @param values The array that contains the values to match.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ field: String, arrayContainsAny values: [Any]) -> Query {
        query = query.whereField(field, arrayContainsAny: values)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must contain
     * the specified field, the value must be an array, and that array must contain at least one value
     * from the provided array.
     *
     * A query can have only one `arrayContainsAny` filter and it cannot be combined with
     * `arrayContains` or `in` filters.
     *
     * @param path The path of the field containing an array to search.
     * @param values The array that contains the values to match.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ path: FieldPath, arrayContainsAny values: [Any]) -> Query {
        query = query.whereField(path, arrayContainsAny: values)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must contain
     * the specified field and the value must equal one of the values from the provided array.
     *
     * A query can have only one `in` filter, and it cannot be combined with an `arrayContainsAny`
     * filter.
     *
     * @param field The name of the field to search.
     * @param values The array that contains the values to match.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ field: String, in values: [Any]) -> Query {
        query = query.whereField(field, in: values)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must contain
     * the specified field and the value must equal one of the values from the provided array.
     *
     * A query can have only one `in` filter, and it cannot be combined with an `arrayContainsAny`
     * filter.
     *
     * @param path The path of the field to search.
     * @param values The array that contains the values to match.
     *
     * @return The created `FIRQuery`.
     */
    func whereField(_ path: FieldPath, in values: [Any]) -> Query {
        query = query.whereField(path, in: values)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` with the additional filter that documents must
     * satisfy the specified predicate.
     *
     * @param predicate The predicate the document must satisfy. Can be either comparison
     *     or compound of comparison. In particular, block-based predicate is not supported.
     *
     * @return The created `FIRQuery`.
     */
    func filter(using predicate: NSPredicate) -> Query {
        query = query.filter(using: predicate)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that's additionally sorted by the specified field.
     *
     * @param field The field to sort by.
     *
     * @return The created `FIRQuery`.
     */
    func order(by field: String) -> Query {
        query = query.order(by: field)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that's additionally sorted by the specified field.
     *
     * @param path The field to sort by.
     *
     * @return The created `FIRQuery`.
     */
    func order(by path: FieldPath) -> Query {
        query = query.order(by: path)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that's additionally sorted by the specified field,
     * optionally in descending order instead of ascending.
     *
     * @param field The field to sort by.
     * @param descending Whether to sort descending.
     *
     * @return The created `FIRQuery`.
     */
    func order(by field: String, descending: Bool) -> Query {
        query = query.order(by: field, descending: descending)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that's additionally sorted by the specified field,
     * optionally in descending order instead of ascending.
     *
     * @param path The field to sort by.
     * @param descending Whether to sort descending.
     *
     * @return The created `FIRQuery`.
     */
    func order(by path: FieldPath, descending: Bool) -> Query {
        query = query.order(by: path, descending: descending)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that only returns the first matching documents up to
     * the specified number.
     *
     * @param limit The maximum number of items to return.
     *
     * @return The created `FIRQuery`.
     */
    func limit(to limit: Int) -> Query {
        query = query.limit(to: limit)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that only returns the last matching documents up to
     * the specified number.
     *
     * A query with a `limit(ToLast:)` clause must have at least one `orderBy` clause.
     *
     * @param limit The maximum number of items to return.
     *
     * @return The created `FIRQuery`.
     */
    func limit(toLast limit: Int) -> Query {
        query = query.limit(toLast: limit)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that starts at the provided document (inclusive). The
     * starting position is relative to the order of the query. The document must contain all of the
     * fields provided in the orderBy of this query.
     *
     * @param document The snapshot of the document to start at.
     *
     * @return The created `FIRQuery`.
     */
    func start(atDocument document: DocumentSnapshot) -> Query {
        query = query.start(atDocument: document)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that starts at the provided fields relative to the order of
     * the query. The order of the field values must match the order of the order by clauses of the
     * query.
     *
     * @param fieldValues The field values to start this query at, in order of the query's order by.
     *
     * @return The created `FIRQuery`.
     */
    func start(at fieldValues: [Any]) -> Query {
        query = query.start(at: fieldValues)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that starts after the provided document (exclusive). The
     * starting position is relative to the order of the query. The document must contain all of the
     * fields provided in the orderBy of this query.
     *
     * @param document The snapshot of the document to start after.
     *
     * @return The created `FIRQuery`.
     */
    func start(afterDocument document: DocumentSnapshot) -> Query {
        query = query.start(afterDocument: document)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that starts after the provided fields relative to the order
     * of the query. The order of the field values must match the order of the order by clauses of the
     * query.
     *
     * @param fieldValues The field values to start this query after, in order of the query's order
     *     by.
     *
     * @return The created `FIRQuery`.
     */
    func start(after fieldValues: [Any]) -> Query {
        query = query.start(after: fieldValues)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that ends before the provided document (exclusive). The end
     * position is relative to the order of the query. The document must contain all of the fields
     * provided in the orderBy of this query.
     *
     * @param document The snapshot of the document to end before.
     *
     * @return The created `FIRQuery`.
     */
    func end(beforeDocument document: DocumentSnapshot) -> Query {
        query = query.end(beforeDocument: document)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that ends before the provided fields relative to the order
     * of the query. The order of the field values must match the order of the order by clauses of the
     * query.
     *
     * @param fieldValues The field values to end this query before, in order of the query's order by.
     *
     * @return The created `FIRQuery`.
     */
    func end(before fieldValues: [Any]) -> Query {
        query = query.end(before: fieldValues)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that ends at the provided document (exclusive). The end
     * position is relative to the order of the query. The document must contain all of the fields
     * provided in the orderBy of this query.
     *
     * @param document The snapshot of the document to end at.
     *
     * @return The created `FIRQuery`.
     */
    func end(atDocument document: DocumentSnapshot) -> Query {
        query = query.end(atDocument: document)
        return self
    }

    
    /**
     * Creates and returns a new `FIRQuery` that ends at the provided fields relative to the order of
     * the query. The order of the field values must match the order of the order by clauses of the
     * query.
     *
     * @param fieldValues The field values to end this query at, in order of the query's order by.
     *
     * @return The created `FIRQuery`.
     */
    func end(at fieldValues: [Any]) -> Query {
        query = query.end(at: fieldValues)
        return self
    }
}

postfix operator |
 
postfix func | (path: String) -> Query {
    return Query(stringLiteral: path)
}
