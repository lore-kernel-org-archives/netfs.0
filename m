Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA1017FE
	for <netfs@lists.linux.dev>; Mon, 18 Nov 2024 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910106; cv=none; b=L1SIT/l61pMRk1CWagdyUpjcw4hUfaqJAPtqtO7FUoDpYGQ6xVBuNhBE9iM7zGTAEqAVZbVQcoXjeqsl+uyQVhDTltFonpYlYJLIfmilnD5zRvj2N0bjby917jdNdmlRSIcuDBrwOkcpJyD84a9QIFFLzgr7QEucP3s1nR9Oa0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910106; c=relaxed/simple;
	bh=cJ2P6uR4opZsVGWIta5h5IZmD3jekZ9UDttr48No1E0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H6Db6fDsON3FDXwG5t5rFYAe8E8j41P00mjVbplPkdmk0EPk+pyg+lufCQ8IlHwElQ6vtjMfqj5FZPIsX9CI/yNFq94ACTQ5nQKTBef9vkjykMquPCJKmU8Hb3mmUZtHkoc+ddS0WrkvDZUwOfNCTPaYD4QTsZ5TBvCJvaIbEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dYp0IAup; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dYp0IAup"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4319399a411so34727635e9.2
        for <netfs@lists.linux.dev>; Sun, 17 Nov 2024 22:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731910103; x=1732514903; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fF7b8budhWUD2De6hv7m+BHsAeeg1J7TYowVwHq0Uok=;
        b=dYp0IAupYfqNUHy1Em8OaKS1K3Tl/82lR3OFE4H4ybo/pLIiVfVc8BogTERE6cM7Kh
         K2iXZL2QLLa1dmlQ4dfCjebFQQBGnqK5JJqnf8kc4OzJ6y7gKO/jHR5j+D4XTtLM7LYb
         zFWuDD0ceuLOuSJ+jFdjxGW3XEvC5bRRQIOz8wd7A0QRGFB/QNJcWGZoLFrHaMgOBDFp
         Po+pnK3Z5VVdc5G63crFyiAQw7XfFIzy/f8P2R+DWnSgVhgBNBIq4EKmubHmn1Wjtjuc
         z3IlOfrJSWTWOnVeL9f6PBBu/NmZwo1+InigGmzvbrG4EGjM7kZvVcyBw0d2QmhP3cIc
         2Yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731910103; x=1732514903;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fF7b8budhWUD2De6hv7m+BHsAeeg1J7TYowVwHq0Uok=;
        b=O0+A4E7mLwDyk91TbGi7Vwkc6ihywsRIuwn4cn9neW/4SaNHqGJRkVK9gj3UPR0NDr
         hJuYw9R2NSL/RUjh/dUC0HOmTNjW5c0kv/jKyg7qR7W4+bbhnY28+WExhpB8KBhT5S7/
         81jnFm3jP4FeFxRpiblP99IGbagzu2mgvPzspAeNEHlh42NvxM/tYeEPp4OZG8QlnAub
         Rw5QBH1YrR+Dh6289siTNGJ/vmkKCwc6YifJNX/dydrDRaiHsyr8lMDYeJ0+LQLBA3iP
         mHifPl0CRcK7tbNy/rkCaUrxIGx8mf8Ft3KNIQZPoaFt0KRL2QJo/NaLfiVzvPto1aaD
         4t+w==
X-Forwarded-Encrypted: i=1; AJvYcCV6TFF1IHAmqIpPgv7LG+qShY671gjaWgTBPFCRFgSalgKXR0u7Ljn+Up+XicvfQav4xQqYBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNisM+XQNBZX1MAbqVbnq1WxC2HCi8YJIFM5veyrvYcMQywPFn
	hL9lTunY3JW8Gpcoi9STTweUf/4bTmr83QmR3OMFU55XIdGZfyybAS1cXzViTnE=
X-Google-Smtp-Source: AGHT+IEro4yYmZP5OKHef+XOzgZ/LRIKlD6qWiYZLHMGCu2nTq/i6YxPj2oMalXqgeMbxjS/2dLAvw==
X-Received: by 2002:a05:600c:4505:b0:431:1868:417f with SMTP id 5b1f17b1804b1-432df74be9amr107263115e9.17.1731910102919;
        Sun, 17 Nov 2024 22:08:22 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab788a2sm141599425e9.11.2024.11.17.22.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 22:08:22 -0800 (PST)
Date: Mon, 18 Nov 2024 09:08:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] netfs: silence an uninitialized variable warning
Message-ID: <867904ba-85fe-4766-91cb-3c8ce0703c1e@stanley.mountain>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that "ret" is uninitialized on the success path if we
don't enter the nested loop at the end of the function.  In real life we
will enter that loop so "ret" will be zero.

Generally, I don't endorse silencing static checker warnings but in this
case, I think it make sense.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/netfs/write_issue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index cd2b349243b3..8f02d8effe78 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -862,7 +862,7 @@ int netfs_writeback_single(struct address_space *mapping,
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
 	struct folio_queue *fq;
 	size_t size = iov_iter_count(iter);
-	int ret;
+	int ret = 0;
 
 	if (WARN_ON_ONCE(!iov_iter_is_folioq(iter)))
 		return -EIO;
-- 
2.45.2

