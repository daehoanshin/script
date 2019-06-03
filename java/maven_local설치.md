
Adding DB2 jdbc drivers to a Maven Java project
You need to get the DB2 drivers, in my case db2jcc.jar and db2jcc_license_cu.jar, then, drop it to a folder at your file system, also, in my case I created a folder /opt/driveDB2 and drop the 2 files there.

Then, run the mvn install command, like in my examples (pay attention in your Version):

mvn install:install-file -Dfile=C:\javaDev\jar\db2jcc4.jar -DgroupId=com.ibm.db2.jcc -DartifactId=db2jcc4 -Dversion=10.1 -Dpackaging=jar -DgeneratePom=true -DcreateChecksum=true

mvn install:install-file -Dfile=C:\javaDev\jar\db2jcc_license_cu.jar -DgroupId=com.ibm.db2 -DartifactId=db2jcc_license_cu -Dversion=10.1 -Dpackaging=jar -DgeneratePom=true -DcreateChecksum=true

At your project, just add the following lines to the pom.xml file:
<dependency>
    <groupId>com.ibm.db2.jcc</groupId>
    <artifactId>db2jcc4</artifactId>
    <version>10.1</version>
</dependency>

<dependency>
    <groupId>com.ibm.db2</groupId>
    <artifactId>db2jcc_license_cu</artifactId>
    <version>10.1</version>
</dependency>
d
