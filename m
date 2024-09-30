Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9408199396
	for <netfs@lists.linux.dev>; Mon, 30 Sep 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722823; cv=none; b=ItCfPUZTuMI38Z0Gl/uN78u4eeZKmItF5BaeG4keq7WzY3mLQQqJGfuRKEr1GpRfTV4ESp1NapdC9G5IJoa80bB+PFxJs8/Bd+F9GCfgQsGEorXl7AUqn5fRPW3L0JR17FUKUMAcCEuuiPAz7PSaBrE06Y5VewVDrzYpWBIzhWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722823; c=relaxed/simple;
	bh=UTeuYgMehmLJA/arPzgIQes3j/4SwwxcY8cev10CXXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+45T/17UUwnDD9n+z6BYwnlhMoF4bmy7W6M+snDu3REzDmakxUSpEX6zVmy4H2q2H2hTVgLX/LzkCBokHF1xdj/aZzj8A+Ux+s+Z6AIH9W7WTrILVGUXMdZEtfJqqneLMXd+vM2FvZv38hCrWra++vQpMwNjmLSI8ZKWqEwDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=C66xGoeo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="C66xGoeo"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718e0421143so672961b3a.0
        for <netfs@lists.linux.dev>; Mon, 30 Sep 2024 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1727722818; x=1728327618; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK4zHMv9BgdsXfJFkQFkyqT5Q9MVxMalN7pOJK+VYMc=;
        b=C66xGoeoV5AABGsfd3g+3oLCxDnEocfV7tZz/TUHQtVefk0dxz9hnbmCEHrUc1kfW4
         vGQc3fxDIFO/x723SMCUoNZNTu0RIVTA7R9TLn2vB5H83VIz9fYoV3x8/DMHfqJx7CtC
         whEHGoq5FDnTkd/EU3v9t4B+h7iVb2XRpXhBjtR3HCExVlaAhEhLnc9lsgNji4El6VFe
         fZcY9N/iT3X+55P38sx6x62Q/0BnvaAoWMg1zFRnW29oVD0MKVUKuzeKKKg3GJ40le7W
         2v2WVwVWvHZOTvOfjbuj6EoKBVykVUWKVm1BrM8mCvPjNjwsfH6KQ+3IK7w4Vr96/ry6
         vxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727722818; x=1728327618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK4zHMv9BgdsXfJFkQFkyqT5Q9MVxMalN7pOJK+VYMc=;
        b=oyrdFHJC04Ch93+evTRROJhdNbLJcHTpeSRlIgk85oR4wLVLaE1SX2dHL4i3C8EOwv
         0X6UMOHhjgecdkUWxsRBzFXmfMNyLO95g4ZtHo5lHuOTpAktwSW2Q7meAxr28eIR8Pha
         hp1DJoHNEI4KO7hHUFklWVNOCidU42Qda7/4HOodBgBtwTzhfKTdV1Dhim0bwJlxCjUf
         IuzpqK0S5IP9B6GYiBO2CPsquzF/J1WOe9xSqIlL7aKDEpSd3BIRiO+993t2F0plLQ1b
         UaK2TlUwHCHueL9HKNEW7YRmOyJiuu9Fkr56ljeT24NJIWv8oucWUbTc728enmdavgn0
         yUPw==
X-Forwarded-Encrypted: i=1; AJvYcCVwFv2uqtzoF754xNxY/n0xpXSxAw4Aeqwdkja6+F4Ss6MTUscP1/Ci6GvT/KkpzQ2j1/GOjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNu+p7ZITdcVhaEEqIDdfwP20yG5oTu21fyvQZfdEB+pXwIcGh
	W/Ymd4pBagMJl1VgL89E2JcBwkt+F8rnqfrNF2rKm+vJvgkwXt3Mo1dGXJNwzc0=
X-Google-Smtp-Source: AGHT+IHr3t4octArrJkwK4KlggdiRYNEixY4E7CvOHzMJxxuBtEfGjyLTrjjT9DROP00qxEU234jog==
X-Received: by 2002:a05:6a00:2392:b0:718:e49f:246e with SMTP id d2e1a72fcca58-71b260a8a3fmr8397735b3a.6.1727722818090;
        Mon, 30 Sep 2024 12:00:18 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:500::6:e49b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652a622sm6544654b3a.164.2024.09.30.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:00:17 -0700 (PDT)
Date: Mon, 30 Sep 2024 12:00:13 -0700
From: Omar Sandoval <osandov@osandov.com>
To: David Howells <dhowells@redhat.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Leon Romanovsky <leon@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org,
	ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
	hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
	netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
	smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
	v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Message-ID: <Zvr1PVRpC33aaUdt@telecaster.dhcp.thefacebook.com>
References: <423fbd9101dab18ba772f24db4ab2fecf5de2261.camel@gmail.com>
 <2968940.1727700270@warthog.procyon.org.uk>
 <20240925103118.GE967758@unreal>
 <20240923183432.1876750-1-chantr4@gmail.com>
 <20240814203850.2240469-20-dhowells@redhat.com>
 <1279816.1727220013@warthog.procyon.org.uk>
 <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
 <2969660.1727700717@warthog.procyon.org.uk>
 <3007428.1727721302@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3007428.1727721302@warthog.procyon.org.uk>

On Mon, Sep 30, 2024 at 07:35:02PM +0100, David Howells wrote:
> Eduard Zingerman <eddyz87@gmail.com> wrote:
> 
> > Are there any hacks possible to printout tracelog before complete boot
> > somehow?
> 
> You could try setting CONFIG_NETFS_DEBUG=y.  That'll print some stuff to
> dmesg.
> 
> David

I hit this in drgn's VM test setup, too, and just sent a patch that
fixed it for me and Manu:
https://lore.kernel.org/linux-fsdevel/cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com/

Thanks,
Omar
