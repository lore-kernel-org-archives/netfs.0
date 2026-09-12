Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342536404D
	for <netfs@lists.linux.dev>; Sat, 12 Sep 2026 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789198490; cv=none; b=blrqqolqi55xm5HfzN0aIPp3I6oirW/wfXtj8B9b285Nvd8rf8/Az/rcHc6wQVt6p0/2vlezHJ4dnPF8cmwXjmUyImMVY7TnOTdyJ5muOmGG1VNi8I67FazqF1wiS8V9RNPCV4swXkxMo27fu0U3Olw7yeBsFtCITTU5y+9PVlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789198490; c=relaxed/simple;
	bh=FuiOWbW64EkXmhSCCZESWu46wUZGuIbP+topqzKMfsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HHh8s+uGGRktTwRZXcNsjrSPW3mLJECutEbo9VKDGEA1X2jiiOfDM/GaGMDnI2LJFi3p8HtO5jJSNAWIKVYYJjpea4JoeE4p6z8U0wIhTf/q2Rr+Ph3kDkZ8K14s00SeeYCrC0QRw19RCIYfW39Oydt4zlOfv7jEG2gcJRApvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5YsFj/7; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5YsFj/7"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so2462085e9.3
        for <netfs@lists.linux.dev>; Sat, 12 Sep 2026 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789198487; x=1789803287; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKzOKf39vUQCKlSSJr14iXhgJoohToEd5zg/sTn5zfI=;
        b=O5YsFj/7LgfJwisUETYkfmKOreF6DGV8K4HV3mfKtltyTLaRRbIjnUUgEd8WnJMaZg
         Ze1EJ8rBAPQZ3Vmn/llaP2fxs/MTMsCaRqVdMrUsIPA+O3fyr+MtxQeyVHWxTnsqnWt/
         8ZH+fLlF/ZeVL7AmPJI6sqRZn4hT9Y2H+RhViUYb+c0EDnhDWp5Hvjn9lKuNjXSu/ipI
         AoqtO5zrd1TiV2p3jeFxYZ2z7ziLkZLuJbPWlWm/237ok8HcTq5LwdUKLG7tKEuh6vwT
         znuJnd5oEKvZM3A9cHU6z/3DieeI46D1zXpIAOs/wt1h5Bnyctatway1uwUvCcDcebOZ
         0vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789198487; x=1789803287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKzOKf39vUQCKlSSJr14iXhgJoohToEd5zg/sTn5zfI=;
        b=UWvT/Icdl4fMtR9Wm5gM52JI6v/C3SkOWSmNoZCymMzJi3PYjj/0elEniY34Ej3jZH
         rx1ClwjKck8c20jgPkIxWHDsgORjjihrswtcQEkIXcvyriyzHF0KmoM9EkUB36KR5zH6
         69DHdBm9CbN/SVGwKa60GRx9oMstvrz/9tMIJ06xeVwpncusu1WoRKq/ocWHXumLViJk
         hHDyrmbGoRUOEoWmmk94xohkLvvj0GGkYs75HBtFhFYA+N0pPW++6AnptnlLMZpjgdbq
         6ZTdRDfhXrw7peZOKOBvtnk7J6ZSaPHEaga8eAAS87c+sTrzQk2GR1DPJTHrq9wH2JA0
         +cgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzt/yzfNLyemnPxHNQxQQSoIj7ICgsBEJYCPjHk7wSRRza0Feu5idNgkS+8xzAhBaODqOC72g==@lists.linux.dev
X-Gm-Message-State: AFuF++m9NN60yP6eNJzz34zd6ipNXMKxxnLPSXsgjr6qWtbCh7ruaarV
	/tL/1Sgx4tqrq7mrpBukG7qNfJrvO8Q4Q8F2xifAD5oy1430dXR76TAy
X-Gm-Gg: AYBFou2Qn8c/tp6sXTtBVo93AdyQzKiBEHdwSDT81nTzGwsuPL0d80uoy5v+CXP+yuw
	kKvfVtS4E+9lnnF1vPwsqkS7qmLsTR3PGsbjVeQiWufLLSf8JLO0KS1nU5bk6FBksgbiPuWqoJX
	O3YoqMWOQvGYi7K5xxQoX0QYnt3U2LfwsY1D7lLdFGU26FCzvzvRQu5dgStk+sTed2cPryWU/Ua
	pkFs7uvGw+IjIDg1FpVpehcx3R0NW1j4/aCOqOlWp9kTT/qcA9TcaQrueeB/SxYq7W0YFte9mwJ
	3p/wMiUDa2QSVW/zLgcUEwmNbxE3DCgZtSMxd1KoyLXE83Y1IIFm7qcwThNkOQZnjX4uhVxHpP1
	FDK0kx9C8l9m+Inip6qe2ZbdA4zrGHWmggJ8vs5jj+cFmWDLpQzLOeAzrhlA1LKf8w7GihIBQBd
	Kt7yvp9nbrGpzrxTkNuEca8pdegVO0PBATC1C3zP6XyBOla3jjA2qYP7eLIcdAqqr643ZG9LfVR
	PV2rU9SmXNM0g6u4zVlFVTdf2H5odXn0sxLaBRnVsMUrk2En+FZGlfHpfIfJEtyRjjBnaF0kGBw
	5q31AIGbVxnT1pXBlcGZ/p+67GvFBxH3HXaWMojUOMXnswAssJ6JRpdoItV9XnUJQFvCNIRmXao
	tnyDDw2Y=
X-Received: by 2002:a05:600c:37c6:b0:49c:fa21:1c8b with SMTP id 5b1f17b1804b1-49e6cc1a4d0mr15498325e9.32.1789198487091;
        Sat, 12 Sep 2026 00:34:47 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ad0614sm147509485e9.10.2026.09.12.00.34.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 00:34:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Document the remote size member and its accessors
Date: Sat, 12 Sep 2026 09:34:44 +0200
Message-Id: <20260912073444.51152-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netfs_inode.remote_i_size was renamed to _remote_i_size and accessors
were added to prevent torn accesses. The netfs library documentation
still shows the old member name.

Update the struct excerpt and member description. Direct readers to
netfs_read_remote_i_size() and netfs_write_remote_i_size(), and state
that writes require inode->i_lock.

Fixes: 2c8f4742bb76 ("netfs: Fix potential for tearing in ->remote_i_size and ->zero_point")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/filesystems/netfs_library.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index ddd799df6ce363d9c348b4f1e82d66b1b54bf4fd..0c9786ffe19240233ea0d8b725dd8300b9f57759 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -195,7 +195,7 @@ structure is defined::
 		struct inode inode;
 		const struct netfs_request_ops *ops;
 		struct fscache_cookie * cache;
-		loff_t remote_i_size;
+		loff_t _remote_i_size;
 		unsigned long flags;
 		...
 	};
@@ -229,11 +229,14 @@ filesystem:
    Local caching cookie, or NULL if no caching is enabled.  This field does not
    exist if fscache is disabled.
 
- * ``remote_i_size``
+ * ``_remote_i_size``
 
    The size of the file on the server.  This differs from inode->i_size if
    local modifications have been made but not yet written back.
 
+   Use netfs_read_remote_i_size() and netfs_write_remote_i_size() to access
+   this field.  Hold inode->i_lock when writing it.
+
  * ``flags``
 
    A set of flags, some of which the filesystem might be interested in:
-- 
2.39.5 (Apple Git-154)

