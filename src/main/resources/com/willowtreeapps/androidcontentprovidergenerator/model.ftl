<#if header??>
${header}
</#if>
package ${config.projectPackageId}.model;

import ${config.providerJavaPackage}.${entity.nameLowerCase}.${entity.nameCamelCase}Cursor;
import com.google.gson.annotations.SerializedName;
<#list entity.fields as field>
<#switch field.type.name()>
<#case "DATE">
import java.util.Date;
<#break>
<#case "ENUM">
import ${config.providerJavaPackage}.${entity.nameLowerCase}.${field.nameCamelCase};
<#break>
</#switch>
</#list>

/**
 * Model object for the {@code ${entity.nameLowerCase}}.
 */
public class ${entity.nameCamelCase}Model{
    <#list entity.fields as field>
    <#if field.serializedName?has_content>
    @SerializedName("${field.serializedName}")
    </#if>
    <#switch field.type.name()>
    <#case "DATE">
    public Date ${field.nameCamelCaseLowerCase};
    <#break>
    <#case "INTEGER">
    public <#if field.isNullable>Integer<#else>int</#if> ${field.nameCamelCaseLowerCase};
    <#break>
    <#case "LONG">
    public <#if field.isNullable>Long<#else>long</#if> ${field.nameCamelCaseLowerCase};
    <#break>
    <#case "FLOAT">
    public <#if field.isNullable>Float<#else>float</#if> ${field.nameCamelCaseLowerCase};
    <#break>
    <#case "DOUBLE">
    public <#if field.isNullable>Double<#else>double</#if> ${field.nameCamelCaseLowerCase};
    <#break>
    <#case "ENUM">
    public ${field.nameCamelCase} ${field.nameCamelCaseLowerCase};
    <#break>
    <#case "BOOLEAN">
    public Boolean ${field.nameCamelCaseLowerCase};
    <#break>
    <#case "BYTE[]">
    public byte[] ${field.nameCamelCaseLowerCase};
    <#break>
    <#default>
    public String ${field.nameCamelCaseLowerCase};
    <#break>
    </#switch>
    </#list>

    public ${entity.nameCamelCase}Model(){}

    public ${entity.nameCamelCase}Model(${entity.nameCamelCase}Cursor cursor){
        <#list entity.fields as field>
        this.${field.nameCamelCaseLowerCase} = cursor.get${field.nameCamelCase}();
        </#list>
    }
}