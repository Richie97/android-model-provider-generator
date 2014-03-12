package ${config.projectPackageId}.api;

import android.app.IntentService;
import android.content.Intent;
import android.os.Bundle;
import java.util.List;
<#list model.entities as entity>
import ${config.projectPackageId}.model.${entity.nameCamelCase}Model;
import ${config.providerJavaPackage}.${entity.nameLowerCase}.${entity.nameCamelCase}Columns;
import ${config.providerJavaPackage}.${entity.nameLowerCase}.${entity.nameCamelCase}ContentValues;
</#list>
import retrofit.RestAdapter;

public class ApiService extends IntentService {
    public static final String API_TYPE = "api_type";
    <#list model.entities as entity>
    public static final int ${entity.nameUpperCase} = ${entity_index};
    </#list>

    RestService service;

    public ApiService() {
        super("Api Service");
    }

    @Override
    public void onCreate() {
        super.onCreate();
        RestAdapter restAdapter = new RestAdapter.Builder()
            .setEndpoint("${config.projectBaseUrl}")
            .build();
        service = restAdapter.create(RestService.class);
    }

    @Override
    protected void onHandleIntent(Intent intent) {
        switch(intent.getExtras().getInt(API_TYPE)){
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
        List<${entity.nameCamelCase}Model> items = service.list${entity.nameCamelCase}();
        getContentResolver().bulkInsert(${entity.nameCamelCase}Columns.CONTENT_URI, ${entity.nameCamelCase}ContentValues.getContentValues(items.toArray(new ${entity.nameCamelCase}Model[items.size()])));
    }
    </#if>
    </#list>
}