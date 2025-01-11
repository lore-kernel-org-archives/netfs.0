Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0ED1ACED9
	for <netfs@lists.linux.dev>; Sat, 11 Jan 2025 15:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736608147; cv=none; b=X+qtJ/ijMPaqKd2O1niKXSzjv3RgX4nRNKTn6uihl8Z7OxldfkX7vqdMJ467wUgbnx5hovgi3gdVOr34U4Qm/3JHswNhFpIuC+UzC7zcER1TsF0/X9CaEvHnkBtVXfhzfJy+5f8BHmk+ZA42u/GEQIpCUu0viUFnu1QxmzRFQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736608147; c=relaxed/simple;
	bh=70xwLrprGfV59lNF8s4RZtXUu1dNiR8GVeqFC80Biis=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=in1Ldl4RYH0RWmVYJjds14sOlny+AMVxk3HV54dCd5oj9P/0MSihWQ00tgVjC4Hghf2RwzKmPiIETcV3YP+So1iBSKCQ2Iud9eR/JJelpJ1MyYFOCaIY8G06A29Uzc5T/WE1l92BPVyThWgcSXlrsdFixzCATv7vP9Q04VCC1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxZwZkC1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxZwZkC1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361f796586so30945315e9.3
        for <netfs@lists.linux.dev>; Sat, 11 Jan 2025 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736608144; x=1737212944; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nt6rAQDmj7inYnwWvjhTb39LKChKA1TheBVsdhMbTrg=;
        b=BxZwZkC15y9J8RjWLseqrdp9mscvMiPYUwADeEfXNiF2JA+JJ2onFfR3fQKPBJL+8M
         fpg9tLX7mMHkrWZLASs/GC56DDsP8qCcOX1z1QFdUMfw666SiylKin2HXPBgDcXc3EsM
         tX2HiQGTsCOo+0VFHqox0IuuHswUREBM10r2csVlBj4I75zlB8LdiDqHcDJL+Wzr1Lok
         +SY/reUUlMnUxtYRsRnF8hRwv70dJnIjrRxgjRbMgChTWNZWbobf1HCzBOn/Dd82vjCu
         M5rWiZ9LcRl4lTbBIJEWZRYOcfiILD//JnBlHSKH3jcNQz2a++XunDFeh9u8HwRr5ZI0
         PuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736608144; x=1737212944;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nt6rAQDmj7inYnwWvjhTb39LKChKA1TheBVsdhMbTrg=;
        b=MtdG75bb1aMrte4ZFmM5Y3xyzbRP6DOugWxioenD4gE7KT2uySUyFQNGOeA+mulD0T
         G/7X7FnMiJL1jVSZxhY+xZ2O/ZmCyvlGvslVxTYhF3luyEOn2xIUc32UCockxZQHOOzO
         N6VRKikiCLfgTxq474fyRau3DAcyc0NRXJzLxWni0cszVGf5/HpiwlZvo9rmqKL9Ma2+
         ALryckyHeniRikWe/tZTgy1bJl4GDzv2kDYQjdzxRJb/bzjOD3a8AjUkJK+niTYiIDu1
         SCutbOPzjnGMFxWMMKEG4Aj8ZJ8rQMx01fDrZnJLnHX38n7uQZ+FiekB0dlsJVn+378O
         R3mA==
X-Gm-Message-State: AOJu0Yy/c12IqesmqERTgJVuGWRZB4YJtioMIEsNLuxefSPiWp+8bnSM
	Erwhvz+N5Tnl1B9uYvtFQ0Bv7Z/NrZ8VuQ5AKqMIHZGyLtONQX6Rp3wUcQ==
X-Gm-Gg: ASbGncvhLfVKeWt38bDgXTQDXjC6dxNm0x1smnud7HVaScixwhKZvnvgRATQly1d4J+
	lZi1CDpvaT6Xftijnyou/XGG0UnJjMkAOsO3Y70HgGzPU+vyrrA/U++pmgp3NCrNcrWBnj+Sy9g
	zM932eliHM3za13PJyOZU16Jrx1a7SCJRqr29qdvj2m482oj5rlIyyM2BBeLIymZJ96uwoPQ66R
	74BU4KW6xndtxDZbXt8fjK8LYuqOqllsJPGimeBev9TX2MG8aYBJN/XYw==
X-Google-Smtp-Source: AGHT+IHgSwDg8T+SP/71HPSM9dqkAgP5umCPT0/LIrMvu3cxwhUQBAc/I1W+a7u3V1/I/FV9gDkREA==
X-Received: by 2002:a05:600c:138a:b0:434:f0df:9fd with SMTP id 5b1f17b1804b1-436e2679a1cmr26207725e9.2.1736608143880;
        Sat, 11 Jan 2025 07:09:03 -0800 (PST)
Received: from gmail.com ([45.250.247.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9d8fd03sm87648335e9.6.2025.01.11.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 07:09:03 -0800 (PST)
Date: Sat, 11 Jan 2025 20:38:56 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: dhowells@redhat.com
Cc: netfs@lists.linux.dev, djwong@kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Error while building with GCC 15
Message-ID: <mb6h75yendy2bxgivjffp65h4zwkwxbehxdloce4hlunfdbvig@rdweinlcy2a6>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

While building with GCC 15 I noticed these build error

fs/netfs/fscache_cache.c:375:67: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  375 | static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
      |                                                                   ^~~~~~~
cc1: all warnings being treated as errors

fs/netfs/fscache_cookie.c:32:69: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   32 | static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
      |                                                                     ^~~~~~~~~~~~
cc1: all warnings being treated as errors

This due to GCC 15 having enabled -Wunterminated-string-initialization
by default[0].

I was first planning on doing something like

--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -372,7 +372,7 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_withdraw_cache);
 
 #ifdef CONFIG_PROC_FS
-static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = { '-', 'P', 'A', 'E', 'W' };
 
 /*
  * Generate a list of caches in /proc/fs/fscache/caches

But then I remembered I did solve a similar bug before where the
developer agreed to just increasing the array size by one[1].
So something like this:

--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -372,7 +372,7 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_withdraw_cache);
 
 #ifdef CONFIG_PROC_FS
-static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE + 1] = "-PAEW";
 
 /*
  * Generate a list of caches in /proc/fs/fscache/caches

So I'm wondering which one would be more appropriate here. Would really
like some help/recommendation then I can send in the patch.

[0]: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wno-unterminated-string-initialization
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a500f3751d3c861be7e4463c933cf467240cca5d

-- 
Regards,
Brahmajit
