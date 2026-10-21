Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560652;
	b=HjaXzHdXLTROVWzni4DhAqH2zegQX4R8hsKNDUYkYMmpqSmsDOA8kTsIkiH00StYaATz
	 kHICK23SCx//dzHWALWqnLRsbtmyl6Y0GpoA0/m2cpAjWD0FhCKuSEJa3JNw3rasLjIlN
	 NomStfOynZd09Yhn7lEvpyPrBhhhEERE+o0XUPZIdc8ztuRLiTDNTh483vV6Hzz/DxF6/
	 Cw2kUWlG4kCbJs5xYNLIu/hX/Q68YLNZkuJpudsshbM/BjF5l1wsvFfl8drBp0V8aHON2
	 m3zigTXxqF1XcURJX+LXB4FIh0k7JKbE/o5vMFh/sEefUMniixQ1Tk5Cctp21txNEpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Message-ID:In-Reply-To:References:Date:
	 MIME-Version:Content-Type;
	bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
	b=DfOM6IvJp0VAQoWi/uz/MfjqEXQTm4Ybk+J0jnF5DtEMZnrjPi67z9Q42HgsiWEyQs27
	 SghTSe61wPf2aKE9ehPGdrNy559d2ZLYaX/89MFnhyDPOnxjkn1Ro9dXRxzmkKgv6XfjA
	 2oMDkMS9rj9TpCF7AT7NFbVCWJS7HFwR6F2316KFofxcEC+Rx20CgBUEWR8XNiL6ZPwF6
	 ahnn86Ja+at0NvrtOuCsza5e9ojpM87sH2c2eWUi2rBssF1CkBLEO/eUl5y6qqRZFIMkX
	 gzBo8AZ8lASRzSUt3fG2GwDZxmCwRPW0VPmM9amqA7fzHq59So55fsMa1u8zEcPgF9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=innovatrics.com;
	spf=pass smtp.mailfrom=innovatrics.com;
	dkim=pass header.d=innovatrics.com header.i=@innovatrics.com header.a=rsa-sha256 header.s=google header.b=xZwCKltf;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4D606A321
	for <netfs@lists.linux.dev>; Wed, 21 Oct 2026 05:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA4D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innovatrics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=innovatrics.com header.i=@innovatrics.com header.a=rsa-sha256 header.s=google header.b=xZwCKltf
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso1757825e9.2
        for <netfs@lists.linux.dev>; Tue, 20 Oct 2026 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innovatrics.com; s=google; t=1792560650; x=1793165450; darn=lists.linux.dev;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
        b=xZwCKltf3zghJTlx8T3lgccnf0K5U1fWzAwkzwC/xr2APRA4aQZpemSR3pJl3p4WQv
         hhpI7CdRBBOM3GG5sMNKX2eWe7Sr6JbS1td00XoELCM6W+r02W7EwwksDUlY6zpIHVxW
         N+Vg3TCfaFtqeMNKGctOGqWWCNYqd7Bisd9r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792560650; x=1793165450;
        h=content-type:mime-version:date:references:in-reply-to:message-id
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wOxW4z1BbQYP9uEvGV85h66bQb0xJWZvNtv4eVINyQQ=;
        b=s8VPTm+/qs9LmPdU4Hfg9kjmCzbjrPUyBaNJAIXUdhTCOMVXz4TYql2gjOyHXXWUjq
         Pzo/MMUohOPGDu7PGJHXAIayKpFEZnIwxvaFOHmY/qng3MDlKNsisby1FJtLDb1cneFY
         AGndruBMXPydlIUjVte3b1d6IZ/5RvEoi7htVRXSiaTs06EnblpWVMDzzzY4QFI3Hnq/
         TTnsXBfk4hZUR0mYUaMVaGDDzopEo5zBt1U74rXQUYeKwCguROBOYm2N0f0zVcECksHc
         k2jgNeYQHaWMrWrjP4Fl62YxI9aBZ0D17CxrpK1IQ/hDOgdmRfWo3AsZp/71vVXhh9iu
         bTxw==
X-Forwarded-Encrypted: i=1; AKwUvBxr71r79U2mfxHr1xjAHAm+oiVk2JcxteGf/k/pAhd3z2cF9TInqOPxpdA6k+PePZ6KumI1Wg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLisL2+iMnuTlzLjXIHdaBCR0w0o5cO1TJ7pVKuPfQP6rCfBUjn
	eM1CQR+u5/If00ku9CIiSZR0GN5G9/4BBWuQdXXdS6vPpnroARQkbs57CU5CfL5+Rw==
X-Gm-Gg: AYBFou3qSE/I8GZezVQpKz8j+8t5dHuwCjyxnSU5e7kB3oXZQCEz4pFVWUIZnizPc7v
	xaugw99dkuKHYVR+wiejRW0wo042/h9IyDC1vqTCWslhMwanbeq9N/5u5zfzmHQFlXQiUqim/Oe
	ii2RtCythwAhFteOohgp9AFy/dd/utDDdupj1vtwqRIFuhNdQLobYwGvobQxi24qVWvLpAA8NUm
	P6sHHWF2J7w/+UyiYraT70Fc1/p/hpq9NI/dClLGyZL7a7+4w9Qr+qAiGYQ98JMr+rtj+YcehVV
	zYW7/VKZIJOR+3hdDPZnrDY0CvwxbS/ADJMbgfnLZq4blghoSkNz/nv9C0s6kM+hBf8i1DvdNGS
	gQq0XKQxVDBt2jv7QLrpnthiHRzLSjhEiyNfCGwIMwfMDnCW9oRisPJAUF/z1JE22b0sz9JLo8t
	2d6/xyT6NU344YrPStlmcHw1Fsqfx4No1re1uj0ovza4x4y7KBLxP2IF5jhlzS03+fWi/EuUxK+
	P91dz36V49RpmO/Ne/d/wQNavbulBFv9yjqJwAd/+T53lZ7Lt+pX6PL5q9UHVeWtp5b3I2X00Or
	ZzpcPPmG0wgycXVhxbjwiDkt8Gk+icldZTsVVoZE9xNULs2XuXqazT2jUk/TnpkuoisSrvrhu8c
	P0AmHHE9TQZrX
X-Received: by 2002:a05:600c:4686:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a1fd72e1e6mr17106685e9.0.1792560650270;
        Tue, 20 Oct 2026 22:30:50 -0700 (PDT)
Received: from [10.11.72.5] (bip-static-148.213-81-147.telecom.sk. [213.81.147.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm85779985e9.5.2026.10.20.22.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:30:49 -0700 (PDT)
From: Petr Chmelar <petr.chmelar@innovatrics.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.org>,
    Matthew Wilcox <willy@infradead.org>,
    Namjae Jeon <linkinjeon@kernel.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Stefan Metzmacher <metze@samba.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    netfs@lists.linux.dev,
    linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 4/5] cachefiles: Don't rely on backing fs storage map
 for most use cases
Message-ID: <20261021.cachefiles-mainline-confirmed.pchmelar@innovatrics.com>
In-Reply-To: <2648476.1792482342@warthog.procyon.org.uk>
References: <20260910220242.2165023-1-dhowells@redhat.com>
 <20260910220242.2165023-5-dhowells@redhat.com>
 <20261011.cachefiles-partial-zeros.pchmelar@innovatrics.com>
 <1655268.1791878098@warthog.procyon.org.uk>
 <20261013.cachefiles-partial-zeros-trace.pchmelar@innovatrics.com>
 <1995693.1791971125@warthog.procyon.org.uk>
 <2648476.1792482342@warthog.procyon.org.uk>
Date: Wed, 21 Oct 2026 05:30:48 +0000
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Post: <mailto:netfs@lists.linux.dev>
List-Help: <mailto:netfs+help@lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
List-Owner: <mailto:netfs+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"

David Howells <dhowells@redhat.com> wrote:

> Note that these patches are now upstream with this change incorporated.

Thanks, David, and sorry for the slow reply to your question about
the fix - I was on vacation.

I've now tested mainline (72a16bcff2) with the same reproducers as in
my earlier mail, and it fixes the problem.  All 4096 blocks read back
correctly on both full reads, and the reads were served from the
cache:

 - 9p, cache=fscache: 0 wrong blocks (936 on 13e340e397).
 - NFSv4.2 loopback with fsc: 0 wrong blocks (817 on 9f8b64f66),
   also after a server-side rewrite of half the file and after
   truncating and regrowing it through the mount.

Thanks again for the quick fix.

Petr
