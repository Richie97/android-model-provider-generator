IMPORTANT: Copy the following into the application tag of your AndroidManifest.xml

<service
    android:name="${config.projectPackageId}.api.PlayerService"
    android:enabled="true" />
<provider
    android:authorities="${config.providerJavaPackage}"
    android:name="${config.providerJavaPackage}.${config.providerClassName}"
    android:exported="false" />