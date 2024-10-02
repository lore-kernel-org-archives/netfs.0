Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860EC748F
	for <netfs@lists.linux.dev>; Wed,  2 Oct 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882526; cv=none; b=mVX/KjtnWt6feIrSaWSkGX+zpd0nevOaJmCZk5Nycib93Uou2ehG5UwpwaIZ/uqDODTIJ6+CDDWwijPi7Ed34zWlbkfqUpXQtzqu6nasV4z+kvdn+RMvy9mbAwNjEGRwTW2lI64992NhpDbcPXG4n/5Oo14N4CP34Ka3Z/gteqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882526; c=relaxed/simple;
	bh=mIPzMdl/U8Z+2nAHifwWJDYD7x1PHUmm+NxHQypeHLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTcZBmJdGrN0kUYYrh9LCKzbk0AfoWplgZpv2dGIbJS/6otH1BlcDZ0yc4Y1j542FpNeNkrrXxdjS8YfB5Yn8DQlWWnnPUvEs4qCaYeJC/IKdyzOn9qoYemFu5rovW96PTJ2HYv+YWZbDgnkFQ3V++h1PjY1/FsP2gZNKr79YUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEy6Lvsa; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEy6Lvsa"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a83562f9be9so147154166b.0
        for <netfs@lists.linux.dev>; Wed, 02 Oct 2024 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727882523; x=1728487323; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPlNQhOvyf3KzT1RAY+EhO/JN1lsJ3MMWmC/Lsg86Ts=;
        b=NEy6Lvsaic024MrxGflC+UluZ8+PmU9WeUX45+mWh7nK3PwaKWkm1ADz2tRmZTvaqm
         xtiJmgpr5veDhijqpWDK4IBVjIKkZgxmet0fI57LauH4MmIjucgJzNm1m69Q1rGHVKF1
         2NGpRRKNaPr8ic0bG3ipd90l30ICSm5NEyLbx26XEM1Y4l9NrsNgnuggFAzLuV+Qow+H
         z/xIToQgTpIAt0dcYlyTbDb3vdGzKUePQ0zs9nNgum6ioX7VmY4vZzuCtAJVD15KLclB
         dd5PQyDtwQO0lBflz7jC5GWpgXjh1xF5YTswsVpXgnoG41CRU5tTnGRnSHD0L5HTiIMF
         D3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882523; x=1728487323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPlNQhOvyf3KzT1RAY+EhO/JN1lsJ3MMWmC/Lsg86Ts=;
        b=w9oFg8dqvH6zPHJq39fRC3oWECPGet2PkFDsoc1ryiS3wnXsEyY516zMqQdf0t7ySW
         jhYsQ8gpBrPxFgs3e+rqpksSZIZsJukxZ2naBqiMb/S4e0n+5L39aWXOogbhdLeypHbt
         vaqXnU2VaAHqTclKRq0JL6BwPNgr4C2oj724hs7JSgcLJxoE0kGvQk2YYtVZ/GoEECvS
         lhlSgTeOrxIENQLEsNrF0HtIVl30xO/pRYqln/OvYmM+JS8+UEJF5+kLHeOmGndNXVPL
         9167PmMhtUkjX+3w0tHMyyFj21l1dH5NBINB4BP7QSkrVbmvaf55TStbkTlKN81nNrmu
         lBRA==
X-Forwarded-Encrypted: i=1; AJvYcCXnR3dhHv2JMTarVrfeKsIH83xC7kTqu8LfQmpd9UR1dlGmeW/8OtHMulMnc0IpxaqbJs0BOQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu0qx+glmkTAj1s583ENS0eeaVeKZ56F3R8hNS0j1Rvg4PD0iO
	sy9JO1YqBsXi3Y+6uh4WqKf/sGgy/Eb3dcTQLk42Z+j3xWA0nkH/
X-Google-Smtp-Source: AGHT+IHChd4yZg8or3ejXPCRc62DPxCE+1UcZY128I/imN4nrDzdsUJuzZtRJdwyo/VQpRbow33hHA==
X-Received: by 2002:a17:907:1c16:b0:a8d:250a:52b2 with SMTP id a640c23a62f3a-a98f8207a97mr309787766b.6.1727882522847;
        Wed, 02 Oct 2024 08:22:02 -0700 (PDT)
Received: from gmail.com ([45.250.247.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c294821bsm872863766b.104.2024.10.02.08.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:22:02 -0700 (PDT)
Date: Wed, 2 Oct 2024 20:51:57 +0530
From: Brahmajit <brahmajit.xyz@gmail.com>
To: dhowells@redhat.com
Cc: jlayton@kernel.org, netfs@lists.linux.dev
Subject: Re: [PATCH 1/1] fs: netfs: making arrays non-null terminated and
 fixing build with GCC 15
Message-ID: <tta2mtxd6n3g4ommh5wakf6y3lwze6a2cvt5jrowbcqtxj62tw@zh4lpfid4woo>
References: <20241002140810.1333092-1-brahmajit.xyz@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002140810.1333092-1-brahmajit.xyz@gmail.com>

On 02.10.2024 19:38, Brahmajit Das wrote:
> My patch fixes the issue by separating the contents of the array into
> each character, this excludes the NUL character thus the string (-PAEW
> or -LCAIFUWRD) being able to fit into thir respective arrays.
> 
> I'm open to better indeas, such as increasing the size of the array by
> one and others.
After writing this initial version of the patch it came to my mind we
can do something like  

diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 9397ed39b0b4..f6b1f7b890a6 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -372,7 +372,7 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_withdraw_cache);
 
 #ifdef CONFIG_PROC_FS
-static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+static const char *fscache_cache_states = "-PAEW";
 
 /*
  * Generate a list of caches in /proc/fs/fscache/caches
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index d4d4b3a8b106..8c82c1f9070f 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -29,7 +29,7 @@ static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
-static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
+static const char *fscache_cookie_states = "-LCAIFUWRD";
 static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)

This approach would be a bit cleaner and shorter, would really like some
opinion on the either of the approaches.
-- 
Regards,
Brahmajit
