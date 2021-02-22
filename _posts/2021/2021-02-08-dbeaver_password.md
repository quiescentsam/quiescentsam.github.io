---
layout: post
title: "Caused by: MetaException(message:Access Denied: ALTER_TABLE on  "
subtitle: spark.sql.hive.caseSensitiveInferenceMode
show-avatar : false
permalink: /blog/spark-developer-metaexception
date: 2021-02-02 00:15:00 -0400
comments: true
published: false
categories: []
tags: [spark, aws]

---

I was working on a spark scala project where I hit the issue `Caused by: MetaException(message:Access Denied: ALTER_TABLE on`, but interestingly I was not running any ALTER TABLE or even a DML, 
then why did I get this error.

A small google search showed that it was because of spark 2.2's default value of ` INFER_AND_SAVE ` for `spark.sql.hive.caseSensitiveInferenceMode`. It simply means that spark tries to read the schema( Case of table name and columns names) from query and save it to actual table. That is where these `ALTER TABLE` statements game from.

So how to solve the issue, just set the value to ` INFER_ONLY`

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

Once I set this, the error is gone!!!

[Stackoverflow reference link](https://stackoverflow.com/questions/57821080/user-does-not-have-privileges-for-altertable-addcols-while-using-spark-sql-to-re)