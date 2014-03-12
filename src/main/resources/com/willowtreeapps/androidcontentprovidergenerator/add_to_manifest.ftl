IMPORTANT: Copy the following into the application tag of your AndroidManifest.xml


<#if config.generateApi>
<service
    android:name="${config.projectPackageId}.api.RestService"
    android:enabled="true" />
</#if>
<#if config.generateProvider>
<provider
    android:authorities="${config.providerJavaPackage}"
    android:name="${config.providerJavaPackage}.${config.providerClassName}"
    android:exported="false" />
</#if>