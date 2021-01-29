# Example of CLI

The examples provide a view on how to use the cli in a pipeline.

To run the script you will need to have the toolkit downloaded.
The toolkit can be retrieved from [IBM Fix Central site](https://www-945.ibm.com/support/fixcentral/) or from the manager node.
The procedure is described at the [knowledge center](https://www.ibm.com/support/knowledgecenter/SSMNED_v10/com.ibm.apic.toolkit.doc/tapim_cli_install.html).

Before been able to run a script, you need to login in the management node. This can be done using the login script.

The script provided are:
- listdrafts: list the available drafts in a provider organization
```
loopback-cicd:1.0.0               https://minimum-mgmt-api-manager-apic.cp4i-mon01-xxxxx
loopback-cicd-prd:1.0.0           https://minimum-mgmt-api-manager-apic.cp4i-mon01-xxxxx
```
- downdrafts-prd: download the provided **product** draft with the referenced APIs.
```
./3-downdrafts-prd.sh loopback-cicd-prd:1.0.0
```
- publishprd-cat: publish the local product into the catalog of a provider organization.
```
./4-publishprd-cat.sh loopback-cicd-prd:1.0.0
```

# Resources
You can find more details on how to use cli in my post [APIC CLI Getting Started](https://prichelle.github.io/2020-07-16-APICCLI-start/).
