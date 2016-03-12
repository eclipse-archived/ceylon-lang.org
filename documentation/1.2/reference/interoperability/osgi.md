---
layout: reference12
title_md: Deploying Ceylon modules in OSGi containers
tab: documentation
unique_id: docspage
author: David Festal
---

# #{page.title_md}

Ceylon is fully interoperable with OSGI, so that Ceylon modules:
- can be deployed as pure OSGI bundles in an OSGI container out-of-the-box without any modification of the module archive file,
- can embed additional OSGI metadata, to declare services for example,
- can easily use OSGI standard services

This provides a great and straightforward opportunity to run Ceylon code inside a growing number of JEE 
application servers or enterprise containers that are based upon (or integrated with) OSGI.

In order to be able to resolve and start Ceylon module archives (`.car` files) inside an OSGI container, you will first need to install, in the OSGI container, all the bundles of the Ceylon distribution and SDK.

#### Retrieving the Ceylon Distribution and SDK for OSGI

In order to be able to resolve and start Ceylon module archives (`.car` files) inside an OSGI container, you will first need to install, in the OSGI container, all the bundles of the Ceylon distribution and SDK.

These bundles are available in a dedicated place on the Ceylon language web site :

- as __OBR bundle repositories__:
    - Old-style OBR syntax (still used by Apache Felix):
        
        https://downloads.ceylon-lang.org/osgi/distribution/1.2.2/repository.xml

        https://downloads.ceylon-lang.org/osgi/sdk/1.2.2/repository.xml

    - New standard R5 OBR syntax:
        
        https://downloads.ceylon-lang.org/osgi/distribution/1.2.2/index.xml
        
        https://downloads.ceylon-lang.org/osgi/sdk/1.2.2/index.xml

- as __P2 repositories for Eclipse development__ :
  
  https://downloads.ceylon-lang.org/osgi/distribution/1.2.2/

  https://downloads.ceylon-lang.org/osgi/sdk/1.2.2/

- as __Zip archives for direct deployment inside containers__ :
  
  https://downloads.ceylon-lang.org/osgi/distribution/1.2.2/ceylon.distribution.osgi.bundles-1.2.2.zip
  
  https://downloads.ceylon-lang.org/osgi/sdk/1.2.2/ceylon.sdk.osgi.bundles-1.2.2.zip

- as __Apache Karaf (aka JBoss Fuse) [features](http://karaf.apache.org/manual/latest/users-guide/provisioning.html)__:
    - `ceylon.distribution.runtime`, available in the following feature repository
    
        https://downloads.ceylon-lang.org/osgi/distribution/1.2.2/karaf-features.xml
    
    - `ceylon.sdk`, available in the following feature repository
      
        https://downloads.ceylon-lang.org/osgi/distribution/1.2.2/karaf-features.xml

#### Installing the Ceylon Distribution and SDK in an OSGI container

##### Apache Felix 5.4.0:

1. Let's assume we start with a fresh installation of Apache Felix v5.4.0 (`org.apache.felix.main.distribution-5.4.0.zip`)

2. In the `conf/config.properties` file of the Felix installation directory, add the following property:

        org.osgi.framework.executionenvironment=J2SE-1.7,JavaSE-1.7,J2SE-1.6,JavaSE-1.6,J2SE-1.5,JavaSE-1.5,J2SE-1.4,JavaSE-1.4,J2SE-1.3,JavaSE-1.3,J2SE-1.2,,JavaSE-1.2,CDC-1.1/Foundation-1.1,CDC-1.0/Foundation-1.0,J2ME,OSGi/Minimum-1.1,OSGi/Minimum-1.0

  This is necessary since by default the Felix OSGI container provided execution environments don't include `J2SE-1.7`, which is required by a transitive dependency of the `ceylon.net` module.

3. In the `conf/config.properties` file of the Felix installation directory, find the `obr.repository.url` property.

4. Uncomment this property if necessary

5. Add the 2 Ceylon following OBR urls at the end of this property (space-separated):
 
        https://downloads.ceylon-lang.org/osgi/distribution/1.2.2/repository.xml https://downloads.ceylon-lang.org/osgi/sdk/1.2.2/repository.xml

6. From the Felix installation directory, Start Felix with the following command:

        java -jar bin/felix.jar

7. From the Felix Gogo shell, deploy the Ceylon Distribution with:
      
        obr:deploy "Ceylon Distribution Bundle"

8. Deploy any SDK module you need with the following command:
      
        obr:deploy ceylon.file

##### Glassfish v4.1:

Since Glassfish is based on Apache Felix, it can be configured to use the OBR.
However the simplest way to install the Ceylon Distribution and SDK bundles is to copy then manually.   

Let's assume we start with a fresh installation of Glassfish v4.1

1. Unzip the 2 zip archives mentioned earlier ([distribution](https://downloads.ceylon-lang.org/osgi/distribution/1.2.2/ceylon.distribution.osgi.bundles-1.2.2.zip) and [sdk](https://downloads.ceylon-lang.org/osgi/sdk/1.2.2/ceylon.sdk.osgi.bundles-1.2.2.zip)) into :

  `../glassfish4/glassfish/domains/domain1/autodeploy/bundles`
  
2. start the glassfish server :

  `../glassfish4/bin/asadmin start-domain`

3. verify that the various Ceylon bundles were deployed correctly in the following log file :

  `../glassfish4/glassfish/domains/domain1/logs`

##### Apache Karaf 4.0.4 (Karaf is a part of JBoss Fuse) with Karaf features:

1. Let's assume we start with a fresh installation of Apache Karaf v4.0.4 (`apache-karaf-4.0.4.zip`)

2. In the karaf installation directory, start Karaf with the following command:

        ./bin/karaf

3. In the karaf shell, add the Ceylon distribution feature repository with the following command:

        feature:repo-add https://downloads.ceylon-lang.org/osgi/distribution/1.2.2/karaf-features.xml

4. In the karaf shell, add the Ceylon SDK feature repository with the following command:

        feature:repo-add https://downloads.ceylon-lang.org/osgi/sdk/1.2.2/karaf-features.xml

5. In the karaf shell, install the Ceylon distribution feature with the following command:

        feature:install ceylon.distribution.runtime

6. In the karaf shell, install the Ceylon SDK feature with the following command:

        feature:install ceylon.sdk
