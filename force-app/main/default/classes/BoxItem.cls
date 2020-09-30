/**
 * The abstract base class for items in a user's file tree (files, folders, etc.).
 */

public abstract class BoxItem extends BoxResource {

    /**
     * An array of all possible file fields.
     */
    public static final list<String> ALL_FIELDS = new list<String> 
        {'type', 'id', 'sequence_id', 'etag', 'sha1', 'name', 'description',
        'size', 'path_collection', 'created_at', 'modified_at', 'trashed_at', 'purged_at', 'content_created_at',
        'content_modified_at', 'created_by', 'modified_by', 'owned_by', 'shared_link', 'parent', 'item_status',
        'version_number', 'comment_count', 'permissions', 'lock', 'extension', 'is_package',
        'folder_upload_email', 'item_collection', 'sync_state', 'has_collaborations', 'can_non_owners_invite',
        'file_version'};

    /**
     * Constructs a BoxItem for an item with a given ID.
     *
     * @param  api the API connection to be used by the item.
     * @param  id  the ID of the item.
     */
    public BoxItem(BoxApiConnection api, String id) {
        super(api, id);
    }
    
}