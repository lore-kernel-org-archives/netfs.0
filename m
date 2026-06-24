Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016EC3B42E9
	for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307781; cv=none; b=DineUamdYy0BqEOM8BeH7yYZidJ3SYtpJwjHRIffBaC8+V2zhcD3j6CvvlbkHBt0+G0hYS98zVHqQphaxbV2g3BSKRXGTbOAA2992qLhyhcx57J0ScGEuiktoCOuGHppLJDf/ViuNBoBLwH2w0BT8EqwaVgLwY078SJKScq6Zvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307781; c=relaxed/simple;
	bh=Rc4DIF8k/idcserzYjIMZTLyU7qERMe9TUYM+fovfvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XxtT8o26NnncxA1jxaop65o7krZBawnqXrYh8UPlwEO+b9E2Ow+ROirXrNlsJGyVz5H69yrJ3qJEt6St+BcyxoH1vJemjDf0BvUC+IbpRpu9Ci8HNosHhr+5ePn0wTGzmSSWyHzQoyDBNuQlp5rvspdI2PXkyPITsjorDNMvvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muq94MPj; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muq94MPj"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-69dead44101so896563eaf.3
        for <netfs@lists.linux.dev>; Wed, 24 Jun 2026 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782307779; x=1782912579; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aCfC/ZU5qfCZc3KzXtYplF4sVu6iTJ7HNvnGz53FoDU=;
        b=muq94MPjNkuoYA3YOawY43sYxGFEyFo7u0zUcKd2PyMPn2qNFPd0ePP32DE1CBgU6a
         aHBSWuILIe1fH6WqJ52kyAQt2LvyFmoZ7K3fge0M8o6wcKQGA6yffK6tIZymA+GNbkEX
         cUCcNSL4mL0SQl953/x8tbjU+WLZNLISG5wUrdRVMhG/tN4f7Y5dHO5ENZvg7V/u2PPV
         zg+S6abMZydEE0WLMuN5AV52Kt5jjW98yRafaJbDeoHqMCiS8P42VUmEaLHeRe+iXGLD
         fSrAxRHEL1BGvtLpWjsU9fmQQxmhPQUfnmQtcMqIv23qC9rDQTbZwsP8xZoo1DSWI6Y8
         6C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782307779; x=1782912579;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCfC/ZU5qfCZc3KzXtYplF4sVu6iTJ7HNvnGz53FoDU=;
        b=LdElJ9G2CsMZYFR6jRc06URlnSFwfvd14IibXRUNxYqy7rbo77rFW+tqYOsUMX3Ct/
         KSP/EwF9cidpb7+JTTQYe8/zMHBz4Os5xoUiC6RR/B6b1okp4TQWyW+9WJDlZRLhnRMg
         el48yLB756Ml9xFRFXq0wa6ALz5wJ+TpPmaGtZkaGX4tFUkUJpVBC+kzy7UDMAbargDG
         SVw2v37Sx7B0OYpUoL9a1ucVFO4OKy+AEJpg3/i3KVqZ+hc1RAgudaTa9c7P32d2oPhE
         NkeVw4WXt8q0190B8mGiDXmpiOSoLZFUtHySfv62oZs1ZCzhb5BXr/qBlS7f+O8X6rZj
         s9oQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pmR29VrIVHI0gd7zIGKs576I9u8TKD4MCuR+KD2/RacG9WrnThMstqBpGnHKN9vgmAKrtfw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMHJJUFZzshlngQQlHQvfo7FM8MJM5Q9Um/nuH2V2G25Pbp4Ms
	wEShrNGAy5LuyHL2WFy8YXunita4YEiGaFpcKaWIWGf05fdFeuGyxZd4
X-Gm-Gg: AfdE7cmadXm2UnoDIiP8RuT65IQ6qgpgHBpoQqwY/dg9x0Qs1yeZHB2AtzLJdQnX6JC
	0II0wT6LwU480iGohRQIjlPly+R3kl9DZE/1p9ctG9uCmcpUtCjJEHig0OFeRTAV/qNISFuRPdU
	OZgsxVLlM3TqJqZzxZYpQST2EKtJqAyc764/XBk9bPr2MM777WiA0hBQt7h7o1ZL6K/GHv0OpPT
	uU9UjP7iuXbykNzAeeDcQEsqwdCb9VdeNziMN3yCGYn4QcScjmGfE7u9Lcd+eGrFV8BOaTZPDjV
	oZjv2202/rkbGzVn2tWvVXPZRO9TmDAOjZqvwAEUDhkHS+Bg30QBYvPC4KdwWq78Q/rWaMHPw91
	7jXMaj3vMVxkkE8GE8Vm3aIaJm8PHLd+G5U01o/2JM8vsR7rIPbS35if6LpJZZbkQPDtnmHx6nC
	kQsxNF8TYsPSVVYLnLClz3y6aeCsak8vh/9mfth1r8DO1ZGlcI6tLeLfuQJ7rH5ZhtSfKOsk63T
	cmfb26CzZRKnRA=
X-Received: by 2002:a05:6820:1898:b0:6a1:129d:26ae with SMTP id 006d021491bc7-6a122f31f70mr2192999eaf.22.1782307778916;
        Wed, 24 Jun 2026 06:29:38 -0700 (PDT)
Received: from [192.168.1.9] ([2401:4900:8836:4853:acf2:b82e:a091:7b0b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9f2a583sm9080203eaf.1.2026.06.24.06.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:29:38 -0700 (PDT)
From: Prashant Rahul <prashantrahul23@gmail.com>
Date: Wed, 24 Jun 2026 18:59:29 +0530
Subject: [PATCH] netfs: Fix kernel-doc parameter name for
 netfs_resize_file()
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-netfs-doc-fix-v1-1-d826fc570a2c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23IJJifQr0cHHWnvR0IhA/Pek4
 wzMVCiUmQqsQ4VMDxdOscM0DuBOEw9C9p1BCqmEkjNGukNBnxwGftEZEjZoLRfroDdXpq7/37a
 39gGR0DWEXwAAAA==
X-Change-ID: 20260624-netfs-doc-fix-cae0bf8825bc
To: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>
Cc: Shuah Khan <shuah@kernel.org>, netfs@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Prashant Rahul <prashantrahul23@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=981;
 i=prashantrahul23@gmail.com; h=from:subject:message-id;
 bh=Rc4DIF8k/idcserzYjIMZTLyU7qERMe9TUYM+fovfvQ=;
 b=owEBbQKS/ZANAwAKAWw+kajX8DhtAcsmYgBqO9u/LSqHSwg46Zw58rxq9yDR8uDQsicnPLn6C
 TS+fKq+Vs+JAjMEAAEKAB0WIQRS5esR6MP3hQs0SsxsPpGo1/A4bQUCajvbvwAKCRBsPpGo1/A4
 bfOjEACVnCnKZvuhwmjBq2EYOs5lBYB+eCzJv4Pwhmt1YZVGi5YAhE3ML8QO9z+KGuFCxy1osoD
 l2TOc8uxvm7iyivSx0c+dIP7kmHwdagiZIKBqrAepyxv00Rs0h/ikLZ4ss8XNNcW4iIBUnPdfmQ
 /0EfVRYD45DwoxHYHXOXxrIyuQ3WwxyQ+4egadsDFONbFeQ0Wm7A6xbZFX1jGBHRNPMP187FDaR
 igeZHW2xqwX3SCd+J1VT4xIqAdW5Qe/uvgSUq+xPENOROuuwKh2OKtB1auM5zLnrivX9t/gWlPt
 W2809kOiE6KBylO0KZmdKtFNYQ0AgHzxnbhDr8H2GXgc/tMSHxooO04z9PTpfXv7z8JqW4UCrWS
 PFkPCMc38PWR1odyBIXsap+OuqmrKUbK24K4iQMGu4oIOEJ4vaCxA5JqDrhUcSYgrmcs4cXuLWY
 cIJXLDDN7+kUBgmDDr7/yDQ0VU80VKZRn3PBAuMNl7bu6ZalC1AxFflUmBJUV+x3bTTyWv6KQS7
 mW7Cgz8MbANtpbiwrujgrWIF3L2MBe24l5/FJJNfPO9ljQXLB8zqf8TAV2+++GmC91lcbS71GN3
 Vy8+P3+8DckL+qxxV3LnwL32WGpq5diPZzydR+X/4UDKJmn4LJcdFohekXrLlNEmyn3T5EOKfAO
 NWqs3RKcIi//z/g==
X-Developer-Key: i=prashantrahul23@gmail.com; a=openpgp;
 fpr=52E5EB11E8C3F7850B344ACC6C3E91A8D7F0386D

Update the kernel-doc comment for netfs_resize_file() to use
'ictx' instead of 'ctx', matching the actual function parameter
name and fixing a kernel-doc warning.

Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
---
 include/linux/netfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 243c0f7379388..bdc270e84b307 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -753,7 +753,7 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 
 /**
  * netfs_resize_file - Note that a file got resized
- * @ctx: The netfs inode being resized
+ * @ictx: The netfs inode being resized
  * @new_i_size: The new file size
  * @changed_on_server: The change was applied to the server
  *

---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260624-netfs-doc-fix-cae0bf8825bc

Best regards,
-- 
Prashant Rahul <prashantrahul23@gmail.com>

