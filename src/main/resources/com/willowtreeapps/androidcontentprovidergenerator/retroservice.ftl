package ${config.projectPackageId}.api;

<#list model.entities as entity>
<#if entity.url?has_content>
import ${config.projectPackageId}.model.${entity.nameCamelCase}Model;
</#if>
</#list>
import java.util.List;
import retrofit.http.GET;
import retrofit.http.Path;
import retrofit.http.Query;

public interface RestService{
    <#list model.entities as entity>
    <#if entity.url?has_content>
    @GET("${entity.url}")
    List<${entity.nameCamelCase}Model> list${entity.nameCamelCase}(
        <#list entity.url?split("/") as x>
        <#if x?starts_with("{")>
        @Path("${x?replace("{", "")?replace("}", "")}")String ${x?replace("{", "")?replace("}", "")}<#if x_has_next>,<#elseif param_has_next>,</#if>
        </#if>
        </#list>
        <#list entity.queryParams as param>
        @Query("${param}")String ${param} <#if param_has_next>,</#if>
        </#list>
        );
    </#if>
    </#list>
}