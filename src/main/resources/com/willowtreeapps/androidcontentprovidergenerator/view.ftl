<#if header??>
${header}
</#if>
package ${config.projectPackageId}.ui.viewmodel;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.RelativeLayout;
import android.widget.TextView;
import ${config.providerJavaPackage}.${entity.nameLowerCase}.${entity.nameCamelCase}Cursor;

import ${config.projectPackageId}.R;
import oak.viewmodel.ViewModel;

/**
 * ViewModel object for the {@code ${entity.nameLowerCase}}.
 */
public class ${entity.nameCamelCase}View extends RelativeLayout implements ViewModel<${entity.nameCamelCase}Cursor>{
   TextView tv;

   public ${entity.nameCamelCase}View(Context context) {
        super(context);
    }

    public ${entity.nameCamelCase}View(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public ${entity.nameCamelCase}View(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();
        tv = (TextView) findViewById(R.id.textView);
    }

    @Override
    public void populate(${entity.nameCamelCase}Cursor item) {
        //Do stuff with Model class
    }
}