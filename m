Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFEF20D4E9
	for <netfs@lists.linux.dev>; Thu, 27 Mar 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071039; cv=none; b=NxMhDgjhIS+q4fAwPfeigtdNnQ4fP7di9177mmSh0YruIfS9/jyTmyvbDhFz3sTzh1PYYpl5y5RtGE6XIzSeJVFvLzxmh/7wC9f02n0zRPZSzPtHLh+9kDR4rL5cluyEs3JX+3ho4FqVeZaxBFIxi9F9bIjf6a5MQsPeMPQQSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071039; c=relaxed/simple;
	bh=V013wu/vGorDr/ot8SkNzxcKrq27+uyzahlU3gimzdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mGw25Hlk7gqfs0i7/rsGu5VYqllopXSWFhyP+dH2YlbVW9g289eGGuNiYZmcRFf1MEIir+ITmq2igclHPR4YJNHm0Bw5qzx9RHfGwRvGEniEBhJVaM/UgkebpJvMb5eO5ruK5ywM+ZG8itR060DjXCjPcyijGtAN88tPbnyjVuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=maTUs3rm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maTUs3rm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso5638675e9.1
        for <netfs@lists.linux.dev>; Thu, 27 Mar 2025 03:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743071036; x=1743675836; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/R4OzXZ/ZUzKB/MaG749sx/0bp5XxQQFr79OGs+bq34=;
        b=maTUs3rm0uMKISSTNu+2WSkVXI0aAIYzUrn2ROH2AwQttpuCxchkaIPJRKW0n/D/H0
         /2UGpZQrAtFJq9psOBA8vCPunWhgVrTmNe5FMQwN/R4Ejr0e9jjA/GfwxG01XWNj1MfU
         +cmze3S36lOu6AFgEDAPXD+0zalLu5S5GKfhl1x8FAfGjAmQ5Vlk3zvCsEv8TJgfwV97
         mBAxGeabtZuRC72oh2UqQzQeJTZClungUq2gG0MPqS0Tk8svDRLzNMHLRxdCm6op3Rtk
         E482+IJd8WjW9bk2jA0kQe6IQdGqcNyLLcRxD7h/cqgi8O/pjuMh6Xalem8CCPx4ejlr
         VJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743071036; x=1743675836;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R4OzXZ/ZUzKB/MaG749sx/0bp5XxQQFr79OGs+bq34=;
        b=TNS3kvo7FFs9SCvtVu7j7TivaMiyTHcGZ3xlxSLO6fAzvrpopHgqBQ4+KtAjkwJ9Qo
         w3TFC4NidjqYkrl93fy70VJ085iUaw5paH0iZRNyFNQDqwfQby6qzmR3TJyosG+DsU3W
         VFKhFUGgtpnNG628e41LQhf7EGfUzZYV97xYG512C3LisIFQCzDXzrbVPkzKnz6mQQbo
         HCHPbFiZOFD0Om15Ak9Ju2mRh5dltvlTBS747CL1oBfwKb3M0RQyEzMcG35d9Cwswe9i
         LqoFmj/WCOSeh/EPAw6g48Ydzak2DyfVVTgY5d6F+gslzvMfKd4tf9Bg81ZUGkTLXbTD
         99xQ==
X-Gm-Message-State: AOJu0YyT7UOoVg7O/w/TEiI8gZECEvH9CCv269zz9QV3e0UGiuayGh8z
	6lS9EutScGzTpiRgTmoY31y++8xR87+zDoUgI6+wbkHmOONiBOQ7VAeAXuYDWMk+A+DYKUZ9/bb
	g
X-Gm-Gg: ASbGncs0Ght07FOi151U2gQ1Ei5k0tH6cRpWl8lCmnP2JXC164fLohieFbm2JP5ad1A
	sDyoAlXsTd3Zy2QV97WN24CC6IX5gI4Vyk+BOutR2JjqPes9PMkoRO1GPYqN7FczK0gGcsook+o
	sR1SnUJgGd1H3kH0nzM5S1fndp7JdK84MqebXeGDRJ6eyzeggYk6wttZCdMGyfyJmw/HNfzFIqw
	RYGQI74qcntoXs7sLOGZq86zp9IjqqBdcUU6hAZT6y94hPM4AP1A2AQgz/1AiTTnViIlIC7eLDW
	ZoHKvLGA5/yt43lQVv/UtEo+G5XYCJPe5OKNQTZuZDVHyOcS4A==
X-Google-Smtp-Source: AGHT+IFvUiuRXHSIMtDd1MbvwFiCiYwLEAZDEj70TrKE5fZGzXWY0JXDsiabPX3pvWTJGCTq/708Ww==
X-Received: by 2002:a05:6000:2c8:b0:391:4389:f363 with SMTP id ffacd0b85a97d-39ad1745b14mr2241669f8f.21.1743071036265;
        Thu, 27 Mar 2025 03:23:56 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d7bfcad9esm36001105e9.1.2025.03.27.03.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:23:55 -0700 (PDT)
Date: Thu, 27 Mar 2025 13:23:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: NeilBrown <neilb@suse.de>
Cc: netfs@lists.linux.dev
Subject: [bug report] VFS: Change vfs_mkdir() to return the dentry.
Message-ID: <ee222b74-6aaa-40f0-8cd1-af0da9e41b37@stanley.mountain>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello NeilBrown,

Commit c54b386969a5 ("VFS: Change vfs_mkdir() to return the dentry.")
from Feb 27, 2025 (linux-next), leads to the following Smatch static
checker warning:

	fs/cachefiles/namei.c:133 cachefiles_get_directory()
	warn: 'subdir' can also be NULL

fs/cachefiles/namei.c
    124                 _debug("attempt mkdir");
    125 
    126                 path.mnt = cache->mnt;
    127                 path.dentry = dir;
    128                 ret = security_path_mkdir(&path, subdir, 0700);
    129                 if (ret < 0)
    130                         goto mkdir_error;
    131                 subdir = ERR_PTR(cachefiles_inject_write_error());

cachefiles_inject_write_error() either return an error pointer or NULL.
Never a valid pointer.

    132                 if (!IS_ERR(subdir))
--> 133                         subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
                                                                                 ^^^^^^
Passing a NULL dereference here will lead to a crash.


    134                 ret = PTR_ERR(subdir);
    135                 if (IS_ERR(subdir)) {
    136                         trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,

regards,
dan carpenter
