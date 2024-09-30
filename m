Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56369193416;
	Mon, 30 Sep 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714804; cv=none; b=lFFeQ1d1DNyWG8oaI92mhB/VLDb0U9RWodU5ZHpNmnwcoSU17Mi+j06GGyVSkjJdVAH3NF5JrmsO7JwsCOPXPHvyXtpNHcJ0W9ejTqkMJloxFP/4NogkSWpG3fg/8wpVyAD4IdYU+rJOPbtVIV90wOS3Ux5gtPPO0UtdffXEzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714804; c=relaxed/simple;
	bh=1rGJ3ml+BkufanYBiG4ElBjkODsCW83l25J2SX/Nfmc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZaUPklMNsKYNvD+Mjh4I/wDxnu0iEmmQP00eS6gJ3B8I/VAYDDFspb3GP1Bu7N9nc0m7urHGcn9Z7ZbzgeZDFcUHPncRdaOmtS2Cni4jEb3CQhE3rv8cxO6wWdC8OQgpRhFhzVNGHzFU/2jfIIzo/53seHYuI6KgW2i8AXmE7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHRJRdLy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHRJRdLy"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e0a060f6e8so3020908a91.1;
        Mon, 30 Sep 2024 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727714803; x=1728319603; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oFMgdLn7hB0TMtt+qsWxpUh5i8iT0KYc/LM27VmdFOA=;
        b=DHRJRdLyXThZmaVvSnbFc+V4trKcJBYqJm7CsUhp30/iOKJG7s4fdnUtBAV8NEc+1m
         2CbBZf3o689135j7kIK0epn7NrdqbiqEWiqAqtU2vOnyP8YOEpiKijSkL8PYjmbSd8MW
         U3jnfMwALo39dXvuiwPzG6wP0JeIjkPmMD0xIjXzDQOOZ9BbO2IaYDD8cgMv72egW2ON
         c2tnV6LLcDb0OIiSHGu3Em0YjNbYEqw3SEtmlh72i/uKAGxfryLTKDpqj0k5aMnpfkzm
         OkrhkkbglpwMjURHW6Wu2n+H/ie5NEgGhqAC22B/BtiUIn1BdaeQr2jX+0UGnuN4KMln
         PTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727714803; x=1728319603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFMgdLn7hB0TMtt+qsWxpUh5i8iT0KYc/LM27VmdFOA=;
        b=X+g7L5SAArv9TXYA32qgtC/2lWTeetd/yuh3RW3yg0Ff7Dnj51HWuz03TTMwyRPGy9
         3PoEwQZWc23W6z+ciqqlPJjisNXw/VwjSUSufuJzebYudguoK77zhdBrKZMAqpeiVp0L
         2Ko7UNtVGDjEYg6pNyadQ8LU/xP6YFWgXdMBuiMdDz+Yjf+cUcNB/QMUsUYx8md0N3JW
         8mFRWRlW6xSjRYbUjlJ3dyDV2OY9tR/co+TVKOEqZjFHrk9ysG7cTO0A2ZXqLT3T4thu
         eOeWjXt8pKdOEJFEIjrkMeXpEVvxMs0TwOp793rb38VWD73JqGiZOKBQ1gOiDLsNrUKu
         CQVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsG4YG1jDzzbPBXRcBnLQiQ0NlRCXyqPAjE/dltxlCbYNSsaTz+SfCmvLG/byFh+i/Lx8foA==@lists.linux.dev, AJvYcCX02Tdog1LWD+lAFTvGzF7H7VzQ+tLH4AwApx+fTWjaMG+VbqFa1pthWExsRZehZoJ70g8VsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAY6Uu7FnqZHzREK0Cvu7KSXiDSQSCh8QJQWMTFsg7G6BEm/Ke
	8H/5IQH84bIIixbU3j7T7CvPgkcRdEVk0O1yhoGIVSt7G9mLEaK7
X-Google-Smtp-Source: AGHT+IFZC3EJ0qzaaUHzbstF3Ibe+95zgKik8WWlYGIZbkQX0EKejoD/dNihbdBEqG2pUNucAQRStA==
X-Received: by 2002:a17:90a:bf03:b0:2e0:a28a:ef88 with SMTP id 98e67ed59e1d1-2e0b8eeebe9mr12068969a91.41.1727714802654;
        Mon, 30 Sep 2024 09:46:42 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c9d354sm8211290a91.25.2024.09.30.09.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 09:46:42 -0700 (PDT)
Message-ID: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com>
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Howells <dhowells@redhat.com>, Leon Romanovsky <leon@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Manu Bretelle
 <chantr4@gmail.com>,  asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
 christian@brauner.io,  ericvh@kernel.org, hsiangkao@linux.alibaba.com,
 idryomov@gmail.com,  jlayton@kernel.org, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-nfs@vger.kernel.org,  marc.dionne@auristor.com,
 netdev@vger.kernel.org, netfs@lists.linux.dev,  pc@manguebit.com,
 smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
 v9fs@lists.linux.dev, willy@infradead.org
Date: Mon, 30 Sep 2024 09:46:36 -0700
In-Reply-To: <2969660.1727700717@warthog.procyon.org.uk>
References: <2968940.1727700270@warthog.procyon.org.uk>
	 <20240925103118.GE967758@unreal>
	 <20240923183432.1876750-1-chantr4@gmail.com>
	 <20240814203850.2240469-20-dhowells@redhat.com>
	 <1279816.1727220013@warthog.procyon.org.uk>
	 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
	 <2969660.1727700717@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-09-30 at 13:51 +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
>=20
> > Okay, let's try something a little more drastic.  See if we can at leas=
t get
> > it booting to the point we can read the tracelog.  If you can apply the
> > attached patch?
>=20
> It's also on my branch:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dnetfs-fixes
>=20
> along with another one that clears the folio pointer after unlocking.

Hi David,

dmesg is here:
https://gist.github.com/eddyz87/3a5f2a7ae9ba6803fc46f06223a501fc

Used the following commit from your branch:
ba1659e0f147 ("9p: [DEBUGGING] Don't release pages or folioq structs")

Still does not boot, unfortunately.
Are there any hacks possible to printout tracelog before complete boot some=
how?

Thanks,
Eduard

