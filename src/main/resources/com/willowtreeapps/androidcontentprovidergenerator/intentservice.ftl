package ${config.projectPackageId}.api;

<#list model.entities as entity>
import ${config.projectPackageId}.model.${entity.nameCamelCase};
</#list>
import java.util.List;
import retrofit.RestAdapter;

public class ApiService extends IntentService {
    public static final String API_TYPE = "api_type"
    <#list model.entities as entity>
    public static final int ${entity.nameUpperCase} = ${entity_index}
    </#list>

    RestAdapter restAdapter;

    public ApiService() {
        super("Api Service");
    }

    @Override
    public void onCreate() {
        super.onCreate();
        restAdapter = new RestAdapter.Builder()
            .setEndpoint("${config.projectBaseUrl}")
            .build();
    }

    @Override
    protected void onHandleIntent(Intent intent) {
        switch(intent.getExtras().getInt(Constants.API_TYPE)){
        <#list model.entities as entity>
        <#if entity.url?has_content>
            case ${entity.nameUpperCase}:
                get${entity.nameCamelCase}FromApi(intent.getExtras());
                break;
        </#if>
        </#list>
        }
    }

    <#list model.entities as entity>
    <#if entity.url?has_content>
    private void get${entity.nameCamelCase}FromApi(Bundle intent){
        List<${entity.nameCamelCase}> items = service.list${entity.nameCamelCase}();
        getContentResolver().bulkInsert(${entity.nameCamelCase}Columns.CONTENT_URI, ${entity.nameCamelCase}ContentValues.getContentValues(items));
    }
    </#if>
    </#list>