Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179967;
	b=hYfrNIou8VRk/rY07ROH0fqGsZRDlPYyZPWGKIuoBC4UhabUs8Uj4k/CpvN4h0ZNynXp
	 CNjgxUYCAbIArOIdgBZaxI8xUaUG2kT22C8GdC4rGZ2l85H21To+ivyvEqfTUggkDUZyR
	 eHoj1UmPlZRC9ec/8zBHIf5ZMbdnaJeCKAyeu8Cr8gZdOmeFOsLCbgVlU2h8QL35ty8ZY
	 boxunm+qD5mB4qIYCvn2qbsuAssC/yQ5CNpP2BhHLpI1G4g6SG7gv2NzN8gMj+7Lg3vVf
	 gSRi5G3enMVdYctdy93449w5eTDXdEhz/xvD/3dZC/ugiZzUWXb/X4CZNRt+GQvFqUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=StDbYCLf8QBugxMgigmlPKTKpnDxInqQmLIcu1D2CBg=;
	b=gLH6T7hLaJ5WbJE2WwAYyEV/W19LXM7mm/UdZUHOd3lpOffc8k8cONuXAD7a7+zgu9L7
	 W9iFt0pDn3+wajD9XbMYqbjrS28YXKw6DvNoQ3u/DzAYm9bFF+SbrVZ6Ap7y8Lo7VtKu5
	 c+XTjUa9dmmkmHAo75MffvGg9OzFuKNnHzYmKKh0Ona67bIcvRwK4AkcB2DERz4z8kLig
	 cXcu+CdMrFlj3e6EmHnQAwCY/xKVnAUV6dHH35rZUOFpOnFtl8me1BZpgCKNLaqW+VIkY
	 jWmqMyT1E7Fc/v1B5Oh/cB4BCPDDfhyV5QctI4SgKL+r0bUUHgf4J7OAQskc5+a1LnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jRqylqtQ;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4C606A31D
	for <netfs@lists.linux.dev>; Wed, 28 Oct 2026 09:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jRqylqtQ
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so380307a12.0
        for <netfs@lists.linux.dev>; Wed, 28 Oct 2026 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793179966; x=1793784766; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=StDbYCLf8QBugxMgigmlPKTKpnDxInqQmLIcu1D2CBg=;
        b=jRqylqtQzFO93NEXQ8DteFq7ehveVXgkf00ZpBfWEk2tnqV+GiYGarAi4HzxL95gTX
         css/al7guuF93hD2S9+ZfVnGzcFVqUdBNrgIHDppk7guu5ZYe/Kq9/ZDdXmodHZo3QEz
         Vln68w4hm4XnSvU0Y3yuhHfPf//HgBkhtoFXjl7Ge5iNUEeRqESc90ZKUx/o+/u1Bu9t
         epMg9xybqjGAYYildgcTuyx2xBR4hQMGq4YTAdrOEAK0mZHocFjeslg6k/9fgJGEjs73
         B2ZOkUzUOfPSKUV5P1l0SGS/TQk+YAs+hB3jdZLA1P5Ca7fYvkWgjnuUPRfBVX6opeRY
         YsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179966; x=1793784766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=StDbYCLf8QBugxMgigmlPKTKpnDxInqQmLIcu1D2CBg=;
        b=lqZNhmBFdj8bx5LLxnBYoIhe5uwa5+is8sx6BJG4juRMsbaUou5KE6gabAYDQFfmPD
         t+VlqQLezktsQZjIEOWVKWRlgojSw1nq3NQUsLTYuK6AIJ8y27VBQcinWdUT84F6S5bW
         4PtAbog03PEf2fjmUkJXHjBG3SxXBGX3eZrEviFfkgX3437ddgJuHbFh+fmnDlGRMv3x
         4GNPxY14Dq2WsHWWmyrrG/Xp8Ib/taZUl0tjyjQisRlr2eh7WFBxxOyexIPD+rXFZhea
         EqLmAMe+mfIS6mGiXNJU0B9dR3/6vAAMlsDYNq9jAGIXwUk+s/Aizgc3biJvFMYmV4ha
         eR/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwq9oeNEe3VqnrW8TBsXzD6/rsHQBHRMsfVYi95NgLfB0pvzJCOjGldZdwVGdOPr96q11vxQA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKbNhIL+uafj7h1D4MDi3wN6MJD7nlqyNczOnVRGteVqZicRGNh
	S0EC2t6rTFSSuLzqB+SmRYqtc7RLRf/8ggvor8yLwmjHrssV96TqNN82
X-Gm-Gg: AYBFou0Ba+u+ZP2+uihcfWYRgeOSuOwfQboPFLZ5GOJ3v2Iwc3k9LiuKQJ1VpkOPuXA
	2mcrJV241Ig9syTKrx4MFMcYM1dGKQs9QOjJvRy/uOVJUaX+sj8ih9Mm0+LUHQ0RnX0NeY0nmPU
	Q7h4jfgCcojr2r7uY0NNjsAG6LM23+7AxYLvlMznE5scXnDPNXOInkEBbMIvNyn2mACXn0K1TfD
	m5D4qwEJU1HmjNjz0uNaqeyEAbJHFPCFhwAussc/RrvpG4OlBRNLHaY8Z9ILCounfRhTRwGyDMA
	0N1hq7yFWT3GdZssH9/MGuWYrChPxutUGxJlZnARdLfbMm1rYVnTNaEkd2OrXTVlNe0CyX2S6NM
	S90aMo4Vvr4xU2Hn8Yuhb0q/BJwISryQBYYx5S3xpD/i5a/8xZYbV+tHNuyydrj+p2b7+G6OGUH
	jGj4+dPEEM9pIhhf4foXpkWr8BVhdR0o9Eg8sFP1Cqg6jjJaQVdfVEEUguEQhi1LOA+0K9GL+6M
	/1uMmuHUS9i0wToj69luJajl/+LIOP0Js7rmerip20Of9hkk3a+yUk4jjbMq2v0gDSg0Tko18C7
	p/QSGkGrOqi553N2EQ7WQGG+FJFK0qh0g+ng7cf9vBdPzCT71RNGbVt+iazIL3Fc
X-Received: by 2002:a17:90b:57e3:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3ae58123796mr1167823a91.37.1793179965718;
        Wed, 28 Oct 2026 02:32:45 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9a5e73sm2211080a91.10.2026.10.28.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:32:44 -0700 (PDT)
From: Jianping Liu <frankljpliu@gmail.com>
To: dhowells@redhat.com,
	jlayton@kernel.org,
	netfs@lists.linux.dev,
	frankjpliu@tencent.com
Cc: linux-kernel@vger.kernel.org,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] cachefiles: return -EEXIST for a repeated secctx command
Date: Wed, 28 Oct 2026 17:32:38 +0800
Message-ID: <20261028093238.1382712-1-frankljpliu@gmail.com>
X-Mailer: git-send-email 2.43.7
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

From: Jianping Liu <frankjpliu@tencent.com>

cachefiles_daemon_secctx() returns -EINVAL when a security context has
already been set. The same errno is used for an empty argument, so
userspace cannot tell the two failures apart.

Return -EEXIST instead, as cachefiles_daemon_dir() and
cachefiles_daemon_tag() do when their setting has already been given.

Fixes: 8667d434b2a9 ("cachefiles: Register a miscdev and parse commands over it")
Cc: stable@vger.kernel.org
Signed-off-by: Jianping Liu <frankjpliu@tencent.com>
---
 fs/cachefiles/daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 1a66e0af2837..ef2ec7afd7cf 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -513,7 +513,7 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 
 	if (cache->have_secid) {
 		pr_err("Second security context specified\n");
-		return -EINVAL;
+		return -EEXIST;
 	}
 
 	err = security_secctx_to_secid(args, strlen(args), &cache->secid);
-- 
2.43.7

