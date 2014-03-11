package ${config.projectPackageId}.api;

<#list model.entities as entity>
import ${config.projectPackageId}.model.${entity.nameCamelCase};
</#list>
import java.util.List;
import retrofit.http.GET;
import retrofit.http.Path;

public interface RestService{
    <#list model.entities as entity>
    <#if entity.url?has_content>
    @GET("${entity.url}")
    List<${entity.nameCamelCase}> list${entity.nameCamelCase}(
        <#list entity.queryParams as param>
        @Query("${param}")String ${param} <#if param_has_next>,</#if>
        </#list>
        );
    </#if>
    </#list>
}