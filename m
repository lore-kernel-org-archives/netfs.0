Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2A39890B
	for <netfs@lists.linux.dev>; Wed,  4 Mar 2026 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616642; cv=none; b=cowGTHHyMoYNnltPO9bGE01OttLeKNG6luGK0E4SR43P1wZB2Fd3Znr20jbn8WstkZoU4Wh0/9KGroS11Wksewg+HGRTxU8SZxzjreYNh+JnfA5Za/Cdn18lTy6TdwmpBi9idp0Y4/1uVBZZ9VgLGqKHFsoh4LvUQxNArXg7BJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616642; c=relaxed/simple;
	bh=qyvL/iXE6+TakoKVVxVCaopqm1BpX+f7Q05dx5gBHDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd29anKsxZuWushZ9MjIhPrS5v/YSQAvKeGBKPKHZur9KGveU/Kg/L8QNtaRfHLuhbOQ5mR8uxy3wL9IV8ZBB8f9CU8XetAdRsnbBCKynQoCGnFYC4Jsqqa6UlP7NNi2gqYVQwPwS3HQoJGAPdkYwlJpSrfRRCdf4RFXZau/N7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXBfZ85W; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXBfZ85W"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483a233819aso64872425e9.3
        for <netfs@lists.linux.dev>; Wed, 04 Mar 2026 01:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772616636; x=1773221436; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
        b=VXBfZ85WCNnS1YA4riE7WlgmBU7lDNyYyUkse0B+ZqjOYf4uij3TO0G0VIVlItsoyQ
         zAisFncEc0hzAiz4WVTGvlxd7IlvTOo6yMyx5qxCLP66yZzaTWPAyJdNuH1ivv4Bjtph
         hWFMcdVn3En92NYldPlrnVGr70YURQO569q9dc9Mnt68sMQBldt9RLTXIQyR37Rg4oze
         GdeM6Es1wjdG5iCUgXW5efpFfJApVOOw9ZFt7aTzcxg7OoXctaJXnzHzyA6zs59BdHgJ
         5tx48GMwBIkyqIWAJ4dlLGO+IKeKjfX749jXPLP1dr4XWtMiVmSdXK1+slJu3yWNQHtU
         pb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616636; x=1773221436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
        b=Q4YapdtP8RMQB8/0zteiqfggUxaTE0Wkl+bcu2kO4zkyiq3qmwuOEgdbDqCVyvoDyc
         Kf0NHNfdb5Yy0Y5ySQWkW0CLP0BnrGSaaMHV6bTZe0ALC6A3sK1Wcr7bkdQSpMTFacCQ
         Xx22DiyDMqZLfHck+x5VWk5XBuP9V80u79BxvB1nuGdluOOxiFSpjyl50BId3L7IYYJe
         pFiAzPweHuHF9Jks6itDno0C+hoP/CTTMdpVyPg7qesRMMlWFVeQcgVfU5jN97VSfFVr
         O7Y5yAy9NeHP/I0M8eVTrifnlKr6HUw5bForP19Pm6XN0NeMB0okzEwUWCC3PU4RCqPR
         9VKg==
X-Forwarded-Encrypted: i=1; AJvYcCVpRkjGaLIn90EiuOnagh97kO8Q21q5xyUjEKSWZr/7eKVe2RCDlql2HyNwEN8S47qaqoj6Fg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yza2TJX6+SMV1U5GTjrBuIWcshz7ASh0SCvoI5iOpVHMpRwThrz
	FaBfHmYamcQNpY5kbWcquIOW1hBQw4RS44gkk2HYifm+gXLw2dOT8OsY
X-Gm-Gg: ATEYQzx1fe/nu5kHuJ6P5MrjZCchRC9W2RKWpgXSJrWcDX+RN/BkBROe+jCcBVrScuQ
	mGnaRmj6AkGK9yvtbnRYQxr5+tkeAMjlOEUMoBWyzI/UAhjyM60OIZaYdNSRrXWFgQR9J6on2MY
	wnQOVivwPSy9pV/zXKG3iJf87fV4yo7fIeAKpDlfUZLBck9fgBLdsLd1YeV93BrgYUHWd2LuZIJ
	tdqHWFEBvfsYKrc7LU02guC53xCBN+Q6CiUz0RIDGRLw8+DgD+npKqoZc0PghVjodiC/TAGFCAV
	66ksJi6oo/OGS+/+YLS88FvNjuDb+StFAA1b8WfyMWhziVH7Isiwqr6A2vJEcZwOQ1fDyBWTwei
	e8AL61xKalWtVrcIRHq8L92B69IPwSWHXawh+yDcmbkmmnnYK+mMIMCGfaahcNuU3dLbHd7STn2
	aa/Bjtb79Gz9iNOkTJYkRN6w+PanU0irr/hK57qR3eJtLN2rZoDU5T51VA5vGhuEES
X-Received: by 2002:a05:600c:8b53:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-4851989024emr19550785e9.26.1772616636117;
        Wed, 04 Mar 2026 01:30:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884225asm38972555e9.6.2026.03.04.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:30:35 -0800 (PST)
Date: Wed, 4 Mar 2026 09:30:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: NeilBrown <neilb@ownmail.net>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, fsverity@lists.linux.dev, linux-mm@kvack.org,
 netfs@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nilfs@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, autofs@vger.kernel.org,
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-x25@vger.kernel.org, audit@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 000/110] vfs: change inode->i_ino from unsigned long
 to u64
Message-ID: <20260304092559.554ac9a9@pumpkin>
In-Reply-To: <177260561903.7472.14075475865748618717@noble.neil.brown.name>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	<1787281.1772535332@warthog.procyon.org.uk>
	<1c28e34c7167acf4e20c3e201476504135aa44e8.camel@kernel.org>
	<177260561903.7472.14075475865748618717@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Mar 2026 17:26:59 +1100
NeilBrown <neilb@ownmail.net> wrote:

> On Tue, 03 Mar 2026, Jeff Layton wrote:
> > On Tue, 2026-03-03 at 10:55 +0000, David Howells wrote:  
> > > Jeff Layton <jlayton@kernel.org> wrote:
> > >   
> > > > This version splits the change up to be more bisectable. It first adds a
> > > > new kino_t typedef and a new "PRIino" macro to hold the width specifier
> > > > for format strings. The conversion is done, and then everything is
> > > > changed to remove the new macro and typedef.  
> > > 
> > > Why remove the typedef?  It might be better to keep it.
> > >   
> > 
> > Why? After this change, internel kernel inodes will be u64's -- full
> > stop. I don't see what the macro or typedef will buy us at that point.  
> 
> Implicit documentation?
> ktime_t is (now) always s64, but we still keep the typedef;
> 
> It would be cool if we could teach vsprintf to understand some new
> specifier to mean "kinode_t" or "ktime_t" etc.  But that would trigger
> gcc warnings.

A more interesting one would be something that made gcc re-write the
format with the correct 'length modifier' for the parameter.

That would save a lot of effort!

	David

> 
> NeilBrown
> 

