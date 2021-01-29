# Shell script using REST API

There are two scripts provided:
- The **publish-direct** script is publishing a product directly in the provided API Connect catalog
- The **publish-withdrafts** script is uploading the api and product in the provider organization drafts and then publish it in the provider organization catalog.

Both scripts are using configuration properties that are defined in the apic.properties file.

## publish-withdrafts

The script lists all the product files (files ending with "-prd.json") and api files (files ending with "-api.json") and will create a file "list_draft-products.txt" and "list_draft-apis.txt" file. These files contains the name of the APIs and Products that will be processed.  

The script performs the following:
- upload the APIs and Products in the manager drafts (develop part UI)
- Publish the products to the catalog of the organization


The product json file should reference the api(s) name that will be published along with the product.  


## publish-direct

The script lists all the product files (files ending with "-prd.json") and will create a file "list_draft-products.txt" file containing all the product file name to deploy.  

The file containing the API definition that is referenced by the product should have the same name as the product where "-prd" is replaced by "-api".  
This script only supports tto reference one API in the product definition. If your product references more APIs, you would need to adapt the script.  
The product json file should reference the api name that will be published along with the product.  

In the product you reference the API as follows:
```json
   "apis": {
        "loopback-cicd": {
            "name": "loopback-cicd:1.0.0"
        }
```
The **name** should match the API definition name:  
```json
    "info": {
        "title": "loopback-cicd",
        "x-ibm-name": "loopback-cicd"
    }
```

The product is directly deployed on the catalog.

# Resources
You can find more details on how to use cli in my post [APIC RESTAPI](https://prichelle.github.io/2020-08-05-APICREST/).
