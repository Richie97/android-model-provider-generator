<#if header??>
${header}
</#if>
package ${config.projectPackageId}.fragment;

import android.app.ListFragment;

import android.os.Bundle;
import ${config.projectPackageId}.R;

import java.util.List;
<#if config.generateProvider>
import android.app.LoaderManager;
import android.content.CursorLoader;
import android.content.Loader;
import android.database.Cursor;
import oak.viewmodel.ViewModelCursorAdapter;
import package ${config.providerJavaPackage}.${entity.nameLowerCase}.${entity.nameCamelCase}Columns;
import package ${config.providerJavaPackage}.${entity.nameLowerCase}.${entity.nameCamelCase}Cursor;
import package ${config.providerJavaPackage}.${entity.nameLowerCase}.${entity.nameCamelCase}Selection;
<#elseif config.generateModels>
import ${config.projectPackageId}.fragment.${entity.nameLowerCase}Model;
</#if>

/**
 * A fragment representing a list of ${entity.nameLowerCase}s.
 */
public class ${entity.nameCamelCase}ListFragment extends ListFragment {

    public static ${entity.nameCamelCase}ListFragment newInstance() {
        ${entity.nameCamelCase}ListFragment fragment = new ${entity.nameCamelCase}ListFragment();
        // Add arguments to bundle
        Bundle args = new Bundle();
        fragment.setArguments(args);
        return fragment;
    }

    /**
     * Mandatory empty constructor for the fragment manager to instantiate the
     * fragment (e.g. upon screen orientation changes).
     */
    public ${entity.nameCamelCase}ListFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            // Instantiate arguments
        }
        <#if config.generateProvider>
        getLoaderManager().initLoader(0, null, new LoaderCallbacks());
        </#if>
    }
    <#if config.generateProvider>
    private class LoaderCallbacks implements LoaderManager.LoaderCallbacks<Cursor> {
        @Override
        public Loader<Cursor> onCreateLoader(int id, Bundle args) {
            // Change the selection to get a subset of your data
            ${entity.nameCamelCase}Selection selection = new ${entity.nameCamelCase}Selection();
            return new CursorLoader(getActivity(), ${entity.nameCamelCase}Columns.CONTENT_URI, ${entity.nameCamelCase}Columns.FULL_PROJECTION, selection.sel(), selection.args(), ${entity.nameCamelCase}Columns.DEFAULT_ORDER);
        }

        @Override
        public void onLoadFinished(Loader<Cursor> loader, Cursor cursor) {
            setListAdapter(new ViewModelCursorAdapter(getActivity(), cursor, true, R.layout.view_${entity.nameLowerCase}));
        }

        @Override
        public void onLoaderReset(Loader<Cursor> loader) {

        }
    }
    </#if>
}