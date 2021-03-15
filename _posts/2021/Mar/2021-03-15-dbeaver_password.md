---
layout: post
title: "How to retrieve stored password in Dbeaver"
subtitle: 
show-avatar : false
permalink: /blog/dbeaver-password
date: 2021-03-15 00:15:00 -0400
comments: true
published: true
categories: []
tags: [database, dbeaver]

---

For most of my database connections and day to day sql use, I use a community edition of a sortware Dbeaver. Dbeaver stores all password locally in this file `~/Library/DBeaverData/workspace6/General/.dbeaver/credentials-config.json` but encrypts it.

Use the below Java code to decrypt it and get to your passwords.

```java
import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.*;

    public class DecryptDbeaver {

        // from the DBeaver source 8/23/19 https://github.com/dbeaver/dbeaver/blob/57cec8ddfdbbf311261ebd0c7f957fdcd80a085f/plugins/org.jkiss.dbeaver.model/src/org/jkiss/dbeaver/model/impl/app/DefaultSecureStorage.java#L31
        private static final byte[] LOCAL_KEY_CACHE = new byte[] { -70, -69, 74, -97, 119, 74, -72, 83, -55, 108, 45, 101, 61, -2, 84, 74 };

        static String decrypt(byte[] contents) throws InvalidAlgorithmParameterException, InvalidKeyException, IOException, NoSuchPaddingException, NoSuchAlgorithmException {
            try (InputStream byteStream = new ByteArrayInputStream(contents)) {
                byte[] fileIv = new byte[16];
                byteStream.read(fileIv);
                Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
                SecretKey aes = new SecretKeySpec(LOCAL_KEY_CACHE, "AES");
                cipher.init(Cipher.DECRYPT_MODE, aes, new IvParameterSpec(fileIv));
                try (CipherInputStream cipherIn = new CipherInputStream(byteStream, cipher)) {
                    return inputStreamToString(cipherIn);
                }
            }
        }

        statc String inputStreamToString(java.io.InputStream is) {
    java.util.Scanner s = new java.util.Scanner(is).useDelimiter("\\A");
    return s.hasNext() ? s.next() : "";
  }

  public static void main(String[] args) throws Exception {
    if (args.length != 1) {
      System.err.println("syntax: param1: full path to your credentials-config.json file");
      System.exit(1);
    }
    System.out.println(decrypt(Files.readAllBytes(Paths.get(args[0]))));
  }  

}
```
compile 
```shell
javac DecryptDbeaver.java
```

extract the password 
```shell
java DecryptDbeaver ~/Library/DBeaverData/workspace6/General/.dbeaver/credentials-config.json
{"dbeaver-sample-database-sqlite-1":{"#connection":{}},"presto_jdbc-17396bcfd9c-1e2791d6bfb34cd3":{"#connection":{"user":"sameer","password":"fd638697f2ac46ef7876428"}}
```



This page have more details about the decrypt obtions for windows and other versions [here][https://stackoverflow.com/questions/39928401/recover-db-password-stored-in-my-dbeaver-connection]