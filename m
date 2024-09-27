Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D701B655F;
	Fri, 27 Sep 2024 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727479328; cv=none; b=tAV/iOG108HqQBDwCmkXjLaMTuoEv8B6rVzcNgncp2st9u+bFJRg+G/b/n/bbueHmYZlS+mvgaMpq0oaqa+Cm52b/6wouFZGwBqhQAhv+P/b4kjbKv5TvvpSoWI3DmSTv5Aqba3yseJvQ5ZveW7wUNX0OI0QhYqyrT0Jsle8NmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727479328; c=relaxed/simple;
	bh=Ni1PSWIgWkGtc+GXe+ot0cv4W+TUNKSABP3D+pYXhYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aljw4uJHbpowFPGlo/yKGUFcKY2flch0V+zTq1LYKG8Ldds/ppo7Lzz9Fbang/eVpz83DRfWHPPNXqSUdSP8UiwAYGfaUMQPdXb7jNOAq0DaQSHhuGv+fXxSyylg4/ryNSdrP7Y7Ef3EK0apqzCSoTWqPajSKjtNlx4NttEthSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f97y8UWV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f97y8UWV"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20afdad26f5so34270755ad.1;
        Fri, 27 Sep 2024 16:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727479327; x=1728084127; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7LAvOZp6Vqb9AO/+VS+wUvq7SL5EIr/lbn9RL5sF1d0=;
        b=f97y8UWVs7POs29tyvSSsxqFU12StlYTFY9aRiYg2JoNttiBlzDLIMMqaKeo/lawcU
         XTvCKh4jM3ItYZofQsYk9M/ZnoSMBXSSUeqlejuIHzOXO2H3XVsIsiUmvMjkao0upktK
         QuHyzE/9gc3gj5t8E5NMjKU7mRtGXVxm1pJwVk9fUp0V4bQnYMm7YceT6Lbbjh4zYirk
         gIka6+aDPDIOBrzE9cDySmICX6kQCbCdsqWz52jmmdKAwAr0AmVQa/X02SRIqY9C1Z7X
         oUPkAEty0d2c+WB43DTRx6XS4piyfQu1LtZSIZFnVHQKpV/qshA18othpsyVJ33izedP
         BM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727479327; x=1728084127;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LAvOZp6Vqb9AO/+VS+wUvq7SL5EIr/lbn9RL5sF1d0=;
        b=h7ieg8b2PerHsU9u38/hWrv5A715/Lu9GYDOLbcbXqY7CHr1iF5fJuIIMDuxw/HIoy
         1Rf8HPzXHGEzW+Mjk3cAVo1C3dTTn9bSUr5L1NqF6BU0kUKqDVsUfbfrPrLjsupdFuFP
         bCh0OmvcMOW6ceQ62NYGtrsoDMWWW40mFHa+Xo3e4TDRx0GTlpJX+j8MOpXIoVMQtHoP
         CDHDymgBmhZ3fAlU405VmVDWNSmREN/HouHu+n7gdqe0LTO/vZAfUKxq/lO/s9GK4/mH
         Vy8s4VB3VY55LW3ZqiB8+9CWqNQhgEQOoFyvE6nx6NtxxmCl5nYyCnX/SHyRO/MFdxK2
         cGvw==
X-Forwarded-Encrypted: i=1; AJvYcCUVlBPwbRN4w5NwOv/kNK7ytyUWEAWcjG27i4wE6qJiXsf6hjyKIbd2qEutCScCD9BPWXtNtw==@lists.linux.dev, AJvYcCXukGQUnuKh7FdRvfQdY/PyI09nTnT2yclG/lkTVVrddtTd42kUbvnJ5g2MugBK0WgGZACCTg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2MAiQSMPBWI+LFf6QF/gZEE38lEMfwbRKO7awXWscPGcXq6D+
	0zE5u10/Y4sFtMJTDzKZXnK0tifSO7zQbn4QgYGFUN2vtio4zrlS
X-Google-Smtp-Source: AGHT+IFXTEMtPJJpJatKRUAfPM6/3maacD+r+Yf+RlOH8FPWHZYjxB+hsah3pGiJOGYuet3l4rSHvQ==
X-Received: by 2002:a17:902:e74e:b0:206:bbaa:84e9 with SMTP id d9443c01a7336-20b37b9b53cmr81601675ad.47.1727479326584;
        Fri, 27 Sep 2024 16:22:06 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e5169csm18253515ad.238.2024.09.27.16.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 16:22:06 -0700 (PDT)
Message-ID: <d87e3b4dfd4624d182d3d23992eacb7b9ffeff90.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org, 
 ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org, 
 hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org, 
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Fri, 27 Sep 2024 16:22:01 -0700
In-Reply-To: <2668612.1727471502@warthog.procyon.org.uk>
References: <55cef4bef5a14a70b97e104c4ddd8ef64430f168.camel@gmail.com>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <2663729.1727470216@warthog.procyon.org.uk>
	 <2668612.1727471502@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2024-09-27 at 22:11 +0100, David Howells wrote:

[...]

> If you look here:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dnetfs-fixes
>=20
> you can see some patches I've added.  If you can try this branch or cherr=
y
> pick:
>=20
> 	netfs: Fix write oops in generic/346 (9p) and generic/074 (cifs)
> 	netfs: Advance iterator correctly rather than jumping it
> 	netfs: Use a folio_queue allocation and free functions
> 	netfs: Add a tracepoint to log the lifespan of folio_queue structs

I used your branch netfs-fixes, namely at the following commit:
8e18fe180b0a ("netfs: Abstract out a rolling folio buffer implementation")

> And then turn on the following "netfs" tracepoints:
>=20
> 	read,sreq,rreq,failure,write,write_iter,folio,folioq,progress,donate
>

System can't boot, so I used the following kernel command line:
... trace_event=3D:netfs_read,:netfs_sreq,:netfs_rreq,:netfs_failure,:netfs=
_write,:netfs_write_iter,:netfs_folio,:netfs_folioq,:netfs_progress,:netfs_=
donate

No warnings like "Failed to enable trace event ...", so I assume it worked
as expected.

A fresh dmesg is here:
https://gist.github.com/eddyz87/e8f4780d833675a7e58854596394a70f

Don't see any tracepoint output there, so something is probably missing.

> > Alternatively I can pack this thing in a dockerfile, so that you would
> > be able to reproduce locally (but that would have to wait till my eveni=
ng).
>=20
> I don't have Docker set up, so I'm not sure how easy that would be for me=
 to
> use.

What's your preferred setup for the repro?

