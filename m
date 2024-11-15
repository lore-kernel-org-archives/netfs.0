Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9E18BC26
	for <netfs@lists.linux.dev>; Fri, 15 Nov 2024 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662034; cv=none; b=UVnmkvX+R4CdQHnm9E1iyu4gmO88tVJl80f4XcuhHxMkKZQdU8o+9cmyreH8CfmrPFOD5rSQ+bfQJoB/XH9ywxpBaQEmcnuMVUP8upf3S7J5tQm+pXtXdE0SRYK9/b+sxljkXYFoM8/mluN58ATecV7O/GA1mX2v5BP7bBsMREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662034; c=relaxed/simple;
	bh=1gpbH+F/EyAt7/qdUtEQNzUhRagbx8xAr7oPVt5RjTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ufKPQoSIGsyPdQwE2VuAy8BT+K/XLMERvvP35eMb3MI0EGkkRI7NBQjvmgK9FoCpaG9ltesPcl4F8EyZkk0P3cDvHCTFT7Hxh3e+73fgA4ghYMuKKt1IGeX8ky41iuzYsAAbRe+G+HM8KRWEtp2Z1DLbW+s8FLY/vkic+/JVNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yDaAeZyL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yDaAeZyL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315eac969aso8853835e9.1
        for <netfs@lists.linux.dev>; Fri, 15 Nov 2024 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731662030; x=1732266830; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8COCFgpNqgb0Y7Anvsa8b6bhjh2JHm033ij5t0kw0Q=;
        b=yDaAeZyLAhltOCJM0P+tRl08TWreVKhlk4870NXo4oXg8EjyaLZbsYg6lMPIHJMeFa
         YGuY2tb/qe7+7KGCzKc1E1b0Z+sI4bmzqco6z54ZXiBNjGR7WJ66qHIqLmfN93ZCbLcy
         uVZ6aEMEEWgJ7NeV7USsc7WfC1Il72ueAxxnbhElbZK6LRZwLxeVpIS5rJgZuLNGd7kE
         4eJd9kbD+xIyVjSig2nY8bj8QOuQg1zHGx+GCkchd3Iig1da3KHVIGxlY6Qd2IhcPuKI
         jrqCZ4e1YfGKl4JuYEAFFjjzM1+sHu9k0At31toN4Jy1VfLcKHmUHsMZlymXVWaFApAm
         gsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662030; x=1732266830;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8COCFgpNqgb0Y7Anvsa8b6bhjh2JHm033ij5t0kw0Q=;
        b=wML0wPlYVYfVn6n08ijG8cu8qCx+gGjhVCEH571v7+igRfhDl0W642fsRNDLfXdhLx
         KMGGSwFcCXg2ZMHEWYnFmIMaIPUg87p/DbQ+vSdrZVd5Czu0tI7aA0otYXxts4OZbc8A
         DVAJswn71+NXFjiHRF5pBtD95GZcF05Gavt+NYfk0GJmwybSgot1Kduzd41yEplq40JP
         OameaWibv7Oi5lE/P79S7906X+ssFBNPf4AotSF6RZcgKGE965RvLQGxfINyND0elx9I
         alNsZDOGa/Mk9hq2a9TVf1VZJWe2RAHUmQGzL0681XdNoNKa6aaxcs5qEPfKEYNpB4cx
         Bb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzSSXxyISYMiH2KlybwiM4H1XFDIEbZo6x31usprNXEYW9vt0Ns9ncaTJ1QYusrJvnnKwTYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjGl0kEOZ7MS+GN+rMVmN9aqIvdwLgfCnQ8Gkw63j5cQOstV34
	ZuP7uPW7soSm2ikJmVrRBOgaKoIAp8VYVtZnOrJ2/LN3u4Vc2d38sk7Cez0DTgA=
X-Google-Smtp-Source: AGHT+IFDwyeF9NdbO3uA8WPZbwIsipDKiK7gl4rjQvHP2ciMl3NTCJLQxQXZjpw4OVLXp1FI70A9Yw==
X-Received: by 2002:a05:600c:a4c:b0:42c:b991:98bc with SMTP id 5b1f17b1804b1-432d95ad53cmr54878725e9.0.1731662029843;
        Fri, 15 Nov 2024 01:13:49 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298c81sm51915835e9.39.2024.11.15.01.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:13:49 -0800 (PST)
Date: Fri, 15 Nov 2024 12:13:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] netfs: Remove duplicate check in
 netfs_cache_read_terminated()
Message-ID: <dfc4ac23-88eb-4293-b4dd-e617779ee7ac@stanley.mountain>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There are two checks for "if (transferred_or_error > 0)".  Delete
the second check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/netfs/read_collect.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 7f3a3c056c6e..431166d4f103 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -597,10 +597,8 @@ void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error, bool
 
 	if (transferred_or_error > 0) {
 		subreq->error = 0;
-		if (transferred_or_error > 0) {
-			subreq->transferred += transferred_or_error;
-			__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-		}
+		subreq->transferred += transferred_or_error;
+		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	} else {
 		subreq->error = transferred_or_error;
 	}
-- 
2.45.2

