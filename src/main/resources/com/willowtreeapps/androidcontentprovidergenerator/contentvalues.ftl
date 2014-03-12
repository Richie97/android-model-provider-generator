<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.nameLowerCase};

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import android.content.ContentResolver;
import android.content.ContentValues;
import android.net.Uri;
<#if config.generateModels>
import ${config.projectPackageId}.model.${entity.nameCamelCase}Model;
</#if>
import ${config.providerJavaPackage}.base.AbstractContentValues;

/**
 * Content values wrapper for the {@code ${entity.nameLowerCase}} table.
 */
public class ${entity.nameCamelCase}ContentValues extends AbstractContentValues {
    @Override
    public Uri uri() {
        return ${entity.nameCamelCase}Columns.CONTENT_URI;
    }

    /**
     * Update row(s) using the values stored by this object and the given selection.
     * 
     * @param contentResolver The content resolver to use.
     * @param where The selection to use (can be {@code null}).
     */
    public int update(ContentResolver contentResolver, ${entity.nameCamelCase}Selection where) {
        return contentResolver.update(uri(), values(), where == null ? null : where.sel(), where == null ? null : where.args());
    }
    <#list entity.fields as field>

    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}(${field.javaTypeSimpleName} value) {
        <#if !field.isNullable && !field.type.hasNotNullableJavaType()>
        if (value == null) throw new IllegalArgumentException("value for ${field.nameCamelCaseLowerCase} must not be null");
        </#if>        
        <#switch field.type.name()>
        <#case "DATE">
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, <#if field.isNullable>value == null ? null : </#if>value.getTime());
        <#break>
        <#case "ENUM">
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, <#if field.isNullable>value == null ? null : </#if>value.ordinal());
        <#break>
        <#default>
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        </#switch>
        return this;
    }

    <#if field.isNullable>
    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}Null() {
        mContentValues.putNull(${entity.nameCamelCase}Columns.${field.nameUpperCase});
        return this;
    }
    </#if>

    <#switch field.type.name()>
    <#case "DATE">
    public ${entity.nameCamelCase}ContentValues put${field.nameCamelCase}(<#if field.isNullable>Long<#else>long</#if> value) {
        mContentValues.put(${entity.nameCamelCase}Columns.${field.nameUpperCase}, value);
        return this;
    }

    <#break>
    </#switch>
    </#list>

    <#if config.generateModels>
    public static ContentValues[] getContentValues(${entity.nameCamelCase}Model... items){
        List<ContentValues> values = new ArrayList<ContentValues>();
        for(${entity.nameCamelCase}Model item : items){
            values.add(getSingleContentValue(item));
        }
        return values.toArray(new ContentValues[values.size()]);
    }

    public static ContentValues getSingleContentValue(${entity.nameCamelCase}Model item){
        ${entity.nameCamelCase}ContentValues values = new ${entity.nameCamelCase}ContentValues();
        <#list entity.fields as field>
        values.put${field.nameCamelCase}(item.${field.nameCamelCaseLowerCase});
        </#list>
        return values.values();
    }
    </#if>
}
