Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA044F54B
	for <netfs@lists.linux.dev>; Thu, 15 Oct 2026 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044928; cv=none; b=NoYdRWtEvnbCHD7cgJtI3eMbdmoRmRZyAgViSw7vj0OXOW9tFp7ZoTjROfoUB5BdSNKTq880fASwiFFtyriFXKyASWSm8hsGkgDEv/vrJmxQAadsyWQDUVTr7gS/m8aD6C1at+0YEjdsoPesAwTcJKMUtdojIq4ODTGgj5ntC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044928; c=relaxed/simple;
	bh=smY6yBPbHEvgEFgKewvO2VX1mQwpxkybfqc6pFJnwSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyjlUqVs81LU3lZJ7TYTt2H/sKrpv9Ue+xL2xxe9/vk1xcqsZZuJJ7tJ81L9FbqI3QTYdhkx8R9KCVhF6Z62XjrcTVhcDC43ynhYIdiVKSC7e4vduLYO1EYHPEmsa3uhQ0A0pC4gIUlXBFSrHEVmMOX0JQ+fobthJ4vWQ+KRQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdUncIP6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdUncIP6"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-487049569b6so3322502f8f.1
        for <netfs@lists.linux.dev>; Wed, 14 Oct 2026 23:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792044919; x=1792649719; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ar2lIaXGZYKNwi8B1Llnt5LR3QyG4oiCO9BSq6FLNgc=;
        b=FdUncIP6lfeRETth560d4VV4IrISONDJHUDpMoCg93TshlY+f9W4GkVxq5faIB7n4G
         Z8ddRS9GzXQSvTeVoGAMRpq1RNxyuYw214LJzufuxRjJLRoZK2Rrqr7IHDGiOYEtCZcX
         8r/21l/8L2rVCFfCtALGgc+CVe9bDFH+gw7SsV5iCwbuEvPujSDDi9cxwyavIEuJGjbM
         Ni2ePMoCIscfOoPpf63VlLnsIn6JJEmiWLBWZeOjxXqExoXhmXpvUrh+AhXDPPX7/EKh
         89gLLe/QLEKncaaqYsiJwj4bFMgm5dSqd9ptcjWYHOn3Vy2BDFg+IUgse2YIBdAUUX3s
         cWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792044919; x=1792649719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ar2lIaXGZYKNwi8B1Llnt5LR3QyG4oiCO9BSq6FLNgc=;
        b=g7R3cp5+aXhG/IpPgO1CE8+QUgEUv8wZPAUeyv106873/o8p5keegEoAJjRt51LDXs
         x0YPG1fFIiZfDvXX5vzL2sSA3rBTpa5awK4tyai6yJwB3ABTcCn1JTTQL3hD/GVmJDiP
         FS3CUkz2ImvY5RwlCDT/my4dfCa/9BmQ/xd/MAglJfAMHVnrkspE3wVruSrVoIVSh7gq
         /dAkCOLmQzb42e+Y0jB17BtF5eD9etRkNmxCQmCR2ap8qBsS8SDNUJ7vwgYkrF//QDu8
         Ny6frvAXPvAnzHDWghh9h9Zb+D4WKS714Pl1nvVpyDiUjxXVyXG06hGaGEQsa/XARUEb
         ypyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIJTmCyQ8zs3xCwphBxstTFchgkPyLov77qDd9CoM5PQOGBL3F+ppBTwnDYytidMKkB83VyQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIMxAm8BJ5y/WeJJxOy7sVQ2MEpS3P7vir29X3Ay2iFDixNS4bZ
	XEogMeCVst/JZaRO/sXEkAJots3Snmnjx1l4HdXC30OWUAMmJcyEFpw5dyKF1pBm
X-Gm-Gg: AYBFou1NT7L0p3SyBnYI4HG2lDcXDPngggnexQK7YfuVqy1lIWZ2/WRc62qZZnEzyMJ
	I/THjUST920wgjQc50Uh0wV9C6cEjb//7FItEXJE/WyeUQ+hvEwTtH+b1mx71GGjSaN6ZOk+NC1
	8GsPirDcXBnrg6LN9la9drwJvok5XMxIT5C8a5kJwJn6Ri9RCOKE337MRZfXLgeNjhUGmPEfnJ3
	oaF5Eofbdc1bjjcH83ClVaWHrwlkFDg9JjXBhwWKII0gz8MSpajwF2zOWOn/xqNajAZpeZ95uY7
	ujM/JHLcXp6FbsKdvf5INKBydMUQeKuxc7xBiyxZghj1S8nS/BnQGmai249T8wAsFiO5T1+Rr4V
	/sTOKoeLc0ll1E2X3jTaTYvVy5r3D4ks5d1458MziELFymR4rp1crhV7XIVka6isq6omyvAwXNe
	9tP1iyBiqIxMwFaeN3T1JbHylxMqywJhiL7sRdfFwYS2I3h5K/Tv6WYnKpGnVdcLFzcvONyolKa
	4ODK20ITI1/0gNTEyf1v6In9R0rvnvNpwZpVAcGb6EHlq7cDunWb2DcNQrRTHHnTIwcyLVC4ZCr
	hClBkzdEZCcmqCuZ6TNEJWN++RdmPIcQk5J6xMeiSmeHXMYrCNCv6sPTTvtPVMSUC2sK0xytSqs
	=
X-Received: by 2002:a5d:6f1c:0:b0:48d:f855:d1e0 with SMTP id ffacd0b85a97d-48df855d30emr211551f8f.57.1792044918908;
        Wed, 14 Oct 2026 23:15:18 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-aeb3-cd01-f139-812c-65df-b930.310.pool.telefonica.de. [2a02:3100:aeb3:cd01:f139:812c:65df:b930])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bd733fsm16578043f8f.58.2026.10.14.23.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:15:17 -0700 (PDT)
Date: Thu, 15 Oct 2026 08:15:15 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Restore selective debug mask handling
Message-ID: <atBvT7c8ZF4szPae@gmail.com>
References: <20260905051738.11317-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905051738.11317-1-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 07:17:38AM +0100, Karl Mehltretter wrote:
> The netfs debug macros test only whether netfs_debug is nonzero.
> Consequently, selecting one debug point enables every entry, exit and
> general debug message.
> 
> Documentation/filesystems/caching/fscache.rst and the NETFS_DEBUG
> Kconfig help still describe /sys/module/netfs/parameters/debug as a
> bitmask of per-stream function entry, exit and general debugging
> points, and the fscache_*.c files still define FSCACHE_DEBUG_LEVEL,
> but nothing has decoded either since the mask handling was dropped
> when FS-Cache was folded into netfs.
> 
> Restore the per-level and per-point mask decoding.  Files that do not
> define FSCACHE_DEBUG_LEVEL, which includes the netfs core, fall under
> the cache management stream, the same default the FS-Cache macros had.
> 
> Fixes: 915cd30cdea8 ("netfs, fscache: Combine fscache with netfs")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

A friendly ping on this debug-mask fix.

Thanks,
Karl
