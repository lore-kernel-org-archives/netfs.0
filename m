Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432499;
	b=Be4tuSko+A8ohIWQvRAaMwL1yXD5G3RuvrYfLJCWYyNuw72RoLWM7Nd8F0zdAs2JUKZ1
	 do+sTPbg3fuexaj5bpqttxmkQa2fvaS+PtefJSoGS+jL9XmPc9ghbdAhFw94N1sfgaRMV
	 0QHnh+e+ylT1C3jyUvmhBg4KO6yK1wt0Po7vTbo+/4PXIujtozfIFmX4cpsgD/ksI4tkf
	 8utHmW3AOtGuEiZ4aBAmiP6ct/ptIAADbDwWKMf8hPETRG9i7d0X9vA/9we49hiHvp4W8
	 N+HHtA+ylEzMWKgZtwldV5xVXmnnBV9wk3zEv34Urk2PQ7PfNz3iQMCH8Z6bt/v2JOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kvxCAFGhBWC5zf+uvhs+QtIakQF9t3AdFIsHU9D4+O4=;
	b=UQmM4u5ShJt2tiNNd9+Er6qQwiRmAFczkXTA1tn8MdFEWxcmAtP1WZaUkdyZrpkWSX3m
	 TXqPNzmgHQL8yeJut2nKjh+rYwSy5w/CFC05Lmmmek7yGFbFcZM8oTqpy9rI/Q3Gg6NpJ
	 bV1h6szrI7XZySauQbJU7GCUN8H/k+SJSdBG98ln5WcLt98kcDgASrBeAy2h20X1mp++q
	 nuntuseG9EdJo3tnYjpkpm1vy+C0h6LV/vIi9B9NLC+Rhst0FDEqJpF4E+pPK/Y4YiSuX
	 DNv5zH4f/cUb1r0zEbonZFaqzphyaiGrD3o3n+oVHsNdxfDHEWRAxtRZ4wnVlkgp32w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wwt3EFtT;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C56606A321
	for <netfs@lists.linux.dev>; Mon, 23 Nov 2026 11:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C56606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wwt3EFtT
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cde7e8abf9cso724733a12.0
        for <netfs@lists.linux.dev>; Mon, 23 Nov 2026 03:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432498; x=1796037298; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kvxCAFGhBWC5zf+uvhs+QtIakQF9t3AdFIsHU9D4+O4=;
        b=Wwt3EFtTz+K5rjuHJn2QmgfwPYqS03YYUmnNsmk4h40XkkHpJplyDaFMPpmStuc1Qx
         VHRX5NaXbhT00LZuZH+hQuq81eaF3MkwSRdyXxM3U1NtsnJuK6p4Crn3+FZ53FSRjdVF
         XWJr11paAQRpnHIEXnT9DnliNH3m5L361y8CVIq9m4oZ58myYsvkWy8ghElLdkkA5zl0
         DARp4txB/CDw/YpyMhA+Yll8xGOqF6Z3h6hsAKLUabPDbwzbkXotURZGvtP9iBT+4JBh
         2XLGKD+kYGMdOG2CIevoJTKXzMC2ghJVJADrdZsDEKJ/UB2bC/wl6xdtEZauwL2w7FA1
         UcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432498; x=1796037298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvxCAFGhBWC5zf+uvhs+QtIakQF9t3AdFIsHU9D4+O4=;
        b=Nk656gO1werRIG/4n+rpZbjKDpnH3NwC7b8SSWrA6E/UTZdiZXcQrCOdJMKYH6qgjl
         U0R33qieJAZstWgO+al46lT+v8f4WUX93GWnaSG9PMFVEWt/zuVquaalAzl4deV+G123
         WrgdUPYSBTdSPr+/XnZFJtSzDjWvrB/RGC7QESkvzaSVMh98Hq557H7fFAYK4bDK/a2O
         z4mQ/+B9BicOR2gzAv4eJgn7041YVOwDGr9UsNgmVbpiAgwNoC1ChYqIbC9He4kgnDJV
         3X1erlp4Oo+arpdF27fBRrwS0YXu3Hpi8QFRbdiVmoIHRSyQLYpHUiX0+iWFo8cLfIsx
         +Kgw==
X-Forwarded-Encrypted: i=1; AL+hErFNpEyUQwnO79HRdMr7cLy0IsxcPKz7yBjsRMgkEu8an9puZ4VpSdMsltzXMNuijc4fesm1jA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8E93kh+secHzNAVJCo8g9KhQ6/MfLPgrNJBB/t13zcOuXJ5k75
	doHl/oo+7XWksonqf87V71+t2z2BVuGtUoyqKcXH784W3qCKY6RazSTj
X-Gm-Gg: AZFdTZfph+DN9H8krQCl35HCqiKOVUB+Sz9q4+LnDeLArcHkDndIR8Qic73m+PgQjRj
	cN2omBB9IB6YchlBwv/yMO4jqZ6bE+jV7fAEz1JSMZ12YJ6i8xifGB86FF10UgUmKhHiYBWFXrT
	+8gnZqES3tjyksCCZJ2dHSJXFEX8WFzjU71Wokhw0vmYK6sgA7lzuObTbshdohvX2R57yzm7bDq
	cc/0Zr3ibxRcElvPYPzfLD2A8R3AkFZh2xE1u2m6tYfjijFPjZrQlgZGh3YGOOpAKIScraPRJEq
	GFU5DCaW8qHy5/Oju57zkVH0yMSYvZ55/kdAqbzAalOL1BQuHfVYgT0J3hVRLSa9NIHJZxHvXTX
	JPGke0GTjlbKg2q/dv75fZr2yaNivyYcNCaK6qH1atLGQshQIerewZNckKdYB9gNeJZxxG0L6UW
	cnqm3UZZvziptFzn3WJCNhTXbGWQh6AXNbeaIbFgTdQKRIn//Qs9OLpqdhTAHU9rNpDMHNuFsrb
	FjWDyv0xGZhbL8q3mbMCjSMJy/2i9+kn7eezHcurM3fARRVkRxboenyHCISb+scy0QweyNeT2ZW
	OqduIB8iFX66+7yB2XS/TGnMdJDBqg==
X-Received: by 2002:a17:90b:3d4d:b0:3a4:fe48:d410 with SMTP id 98e67ed59e1d1-3b41c92cfe2mr10003902a91.30.1795432498380;
        Mon, 23 Nov 2026 03:14:58 -0800 (PST)
Received: from thangnn-ASUS.. ([2a09:bac5:d452:16c8::245:e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad8ef99sm18070874a91.12.2026.11.23.03.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:14:58 -0800 (PST)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com
Subject: [PATCH] ima: key iint mutex lockdep class per filesystem type
Date: Mon, 23 Nov 2026 18:14:52 +0700
Message-ID: <20261123111452.237422-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a circular locking dependency between the iint mutex,
a 9p inode's i_rwsem and the sb_writers of the cachefiles backing fs:

  sb_writers#12 --> &ima_iint_mutex_key[depth] --> &sb->s_type->i_mutex_key#25

The three edges are:

  backing fs O_TRUNC open:  sb_writers(backing) -> iint(backing inode)
  9p open + IMA hash:       iint(9p inode)      -> i_rwsem(9p inode)
  9p truncate/writeback:    i_rwsem(9p inode)   -> sb_writers(backing)

The last one is inherent to netfs: it writes to its cachefiles backing
file under its own inode lock. The cycle only closes because the iint
mutex is keyed by s_stack_depth alone, so the 9p and backing fs iints,
both at depth 0, share one lockdep class. They are different inodes
and nothing waits on a netfs iint while holding the backing fs's
sb_writers, so this is a false positive.

Key the iint mutex per filesystem type as well as depth, as is done for
i_rwsem with s_type->i_mutex_key. The overlayfs case covered by the
depth annotation is unchanged.

Fixes: e044374a8a0a ("ima: annotate iint mutex to avoid lockdep false positive warnings")
Reported-by: syzbot+deb8af81d91415fabac1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=deb8af81d91415fabac1
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Tested in QEMU on v7.4-rc4 (syzbot config, ima_policy=tcb): cachefiles
bound on an ext4 disk, 9p over virtio with cache=fscache, then 50 rounds
of write + O_RDONLY|O_TRUNC open on 9p and on the backing fs, followed by
20 IMA-measured O_TRUNC opens through an overlayfs on the backing fs.

  unpatched: "possible circular locking dependency detected", same chain
  patched:   no lockdep report, debug_locks still 1; the syzbot C repro
             also ran 90s with no report

 include/linux/fs.h                |  3 +++
 security/integrity/ima/ima_iint.c | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100aba77b..dab32eea21fc7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2325,6 +2325,9 @@ struct file_system_type {
 	struct lock_class_key i_mutex_dir_key;
 
 	struct lock_class_key d_lookup_key;
+#ifdef CONFIG_IMA
+	struct lock_class_key ima_iint_key[FILESYSTEM_MAX_STACK_DEPTH + 1];
+#endif
 };
 
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index 00b249101f98d..bb964847af149 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -39,19 +39,22 @@ struct ima_iint_cache *ima_iint_find(struct inode *inode)
  * files both on overlayfs and on underlying fs, we need to annotate the iint
  * mutex to avoid lockdep false positives related to IMA + overlayfs.
  * See ovl_lockdep_annotate_inode_mutex_key() for more details.
+ *
+ * Depth alone is not enough: a netfs inode writes to its cachefiles backing
+ * fs under its own i_rwsem, and both are at depth 0. So, like i_rwsem, key
+ * the mutex per filesystem type too.
  */
 static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
 					     struct inode *inode)
 {
 #ifdef CONFIG_LOCKDEP
-	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
-
-	int depth = inode->i_sb->s_stack_depth;
+	struct super_block *sb = inode->i_sb;
+	int depth = sb->s_stack_depth;
 
 	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
 		depth = 0;
 
-	lockdep_set_class(&iint->mutex, &ima_iint_mutex_key[depth]);
+	lockdep_set_class(&iint->mutex, &sb->s_type->ima_iint_key[depth]);
 #endif
 }
 
-- 
2.43.0

