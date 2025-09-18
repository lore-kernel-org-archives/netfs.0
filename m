Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4AD1EF39E
	for <netfs@lists.linux.dev>; Thu, 18 Sep 2025 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758157640; cv=none; b=eBdrcUowQ0zpghNWkCNZkhvP5SRJMXZ1EWQDQfxwHNWlOjzd3eUPKk9O+AvU/gljL0rvvXDRIS1PmGPzIDjlUdlB1MuERcB/DEDtY3VtZGvHuuSMNb9m8CgnJUewD29NfLQQVPtdNC86Qjm64pv4DyAmeeEREv+v579dtVtHaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758157640; c=relaxed/simple;
	bh=Jyh/T1VQujpBIetRlEwQ9WKQ0pDM9Occu70Vj9kJ3PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emf6aNKVy4ZBi3kwbwEUb3yeTytTAq/7GgM8bpPTS7l81L0niMaVU19+Gtlpcj0ilb7uHB+SYmCJu8HANSSfKL1xev8XsyOyiR+IGWz66/vN/5+6Xb11jKqkoAPUBub2hMKYMwbZry5HZZjF1kcILYj+K+x+mRRV7BHRccxM7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=eD75w7j7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="eD75w7j7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77287fb79d3so454211b3a.1
        for <netfs@lists.linux.dev>; Wed, 17 Sep 2025 18:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1758157638; x=1758762438; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p3n6Uf5fmho3K1YmaoGj4njt8YRbuIHtLi1zAXG6OwM=;
        b=eD75w7j7E4Q2qhXhqY4qef97bNY5l1QbHF4uFc7A8zm2UGpMC3nlfmZw2/yZTOWgyg
         kRjdJ1qqD4dO2nJeotKbeQ1L83gS/1OduSJRcrB7xq31fAevsnAuYq8z+IHpDC9EYDzo
         c3s+xcYBpBCPmG051Qh2lcZNr0+cqUPk5PCRdjRXeI3IR2XPC3qvtYVe389BUg8cyAgT
         zR8VZMm/4DsQtfWU7pVjyqowrS1a09o5JK6ihG0dbvaiQRU8tYuyFPocpS1oBedO9MTi
         zPPRG3RE8ny/y+T87IdiFmjFZmpnzuOSYKW3FF3pG3PZsXNFQBQUdgLTZ4zxLpBur/JP
         HJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758157638; x=1758762438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3n6Uf5fmho3K1YmaoGj4njt8YRbuIHtLi1zAXG6OwM=;
        b=tO1hoTHWCUP7oRfNrk3NJ3W9WpfDN+0H084EutohPfBeAw83Ci1xUrC6LSXcvwYaWL
         469uAs9rAxn+EOOHij0YjekIYHYLAQkoqWWcINzVLP8UmXIiFNsJcE49NrKhV6aOF10e
         jW0qjVx4tuckBsHLRuNTkAwCSHiFHm4dRtX8VzStrGIihPci8QXg0Q5irYw2T1xhsSES
         xTLcmdGwi3egfcTEfKwx6Tou7pyLOG3dQqmSlG95s7gk0SGx6/i2iOKWzdjnv4rMISIk
         bVz7F7iVsjWU8nhFOtFLKihIaF+9kqBotBvPxmJ7/ui8nuBXemEQq4YFXianXXIZfBwu
         TK1g==
X-Forwarded-Encrypted: i=1; AJvYcCVv+EtGGXEgeenOXwFqx2X/MPdZJ8TDAon0sfEhPDcuugR1Mkz52jTU1LvrRTexAud4zSnbuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2BZhxaAw4csmVK5EfVEpktoFIyiF6mLRAO3oZSE1VK3ND0iRh
	KtlGe3yQL066581QOEdJ/4V72jWjNuQuuPDoo4BOZGrS48gKDEYnQFyiiOcdiGwtLL0=
X-Gm-Gg: ASbGnct3FfZjsPNHEW0XZ+/3bt/ZdVtJoJ6UNLPyJeeTDnjz/+d9NdW6UBzKjtfWyag
	mM0DF85T4uqVYNd/+XqSO0ymbXimnO36DtqyvTtNslFBYedToazH+j5upM6V/ig0KEUYLhVSDX5
	XREdxDXGnivVaCkz0KRVBb4Puwr4nUp/x0rr7U64g8Kw2FIY68gUMd19GbvZRzGgAEb2FbZ8u7Q
	YhQi7geGMJz6NBD1jQXDbVbZh3cnF72X7h/0Y0Pgti5HF08OnGQdXeQVrjuE6o0pVL9Ee2NvVNl
	nZgq9aergOK6b6KMUiP6HP+4+FWtjO53R6XWNroLq9MiOxHuU5MAO30/U1Js4p2uEASHMziTTHk
	8jsPqR4wJ0nRZ4jNG8udSt5B6M/xntdWIkoDEa5DetSF7znNk8EzbnxLYv7n/+MYdArfGJ8of2p
	Dh9zIcnQ==
X-Google-Smtp-Source: AGHT+IGuCJoEhQgAv+Omg49c7c/B2Tcr3E0BGIChrElfWl6Pxd6ZK4K1F7fPmkeQRRASiKleSW/EoQ==
X-Received: by 2002:a05:6a00:2350:b0:776:1834:c8c7 with SMTP id d2e1a72fcca58-77bf9664586mr4517640b3a.26.1758157638566;
        Wed, 17 Sep 2025 18:07:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec40185sm605187b3a.77.2025.09.17.18.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:07:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uz37D-00000003LBO-2MNV;
	Thu, 18 Sep 2025 11:07:15 +1000
Date: Thu, 18 Sep 2025 11:07:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, slava.dubeyko@ibm.com,
	xiubli@redhat.com, idryomov@gmail.com, amarkuze@redhat.com,
	ceph-devel@vger.kernel.org, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls
 asynchronous
Message-ID: <aMtbQzb-aFPtjttc@dread.disaster.area>
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <aMs7WYubsgGrcSXB@dread.disaster.area>
 <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHb38eeqPdwjBpkweEwsa6_DTvdrXr2jYmcJ7h2EpMyQg@mail.gmail.com>

On Thu, Sep 18, 2025 at 01:08:29AM +0200, Mateusz Guzik wrote:
> On Thu, Sep 18, 2025 at 12:51 AM Dave Chinner <david@fromorbit.com> wrote:
> > - wait for Josef to finish his inode refcount rework patchset that
> >   gets rid of this whole "writeback doesn't hold an inode reference"
> >   problem that is the root cause of this the deadlock.
> >
> > All that adding a whacky async iput work around does right now is
> > make it harder for Josef to land the patchset that makes this
> > problem go away entirely....
> >
> 
> Per Max this is a problem present on older kernels as well, something
> of this sort is needed to cover it regardless of what happens in
> mainline.
> 
> As for mainline, I don't believe Josef's patchset addresses the problem.
> 
> The newly added refcount now taken by writeback et al only gates the
> inode getting freed, it does not gate almost any of iput/evict
> processing. As in with the patchset writeback does not hold a real
> reference.

Hmmmm. That patchset holds a real active reference when it is on the
LRU list.

I thought the new pinned inode list also did the same, but you are
right in that it only holds an object reference.  i.e. whilst the
inode is pinned, iput_final won't move such inodes to the LRU and so
they don't get a new active reference whilst they are waiting for
writeback/page cache reclaim.

That in itself is probably OK, but it means that writeback really
needs to take an active reference to the inode itself while it is
flushing (i.e. whilst it has I_SYNC is set). This prevents the fs
writeback code from dropping the last active reference and trying to
evict the inode whilst writeback is active on the inode...

Indeed, comments in the patchset imply writeback takes an active
reference and so on completion will put inodes back on the correct
list, but that does not appear to be the behaviour that has been
implemented:

	"When we call inode_add_lru(), if the inode falls into one of these
	categories, we will add it to the cached inode list and hold an
	i_obj_count reference.  If the inode does not fall into one of these
	categories it will be moved to the normal LRU, which is already holds an
	i_obj_count reference.

	The dirty case we will delete it from the LRU if it is on one, and then
	the iput after the writeout will make sure it's placed onto the correct
	list at that point."

It's the "iput after the writeout" that implies writeback should be
holding an active reference, as is done with the LRU a couple of
patches later in the series.

> So ceph can still iput from writeback and find itself waiting in
> inode_wait_for_writeback, unless the filesystem can be converted to
> use the weaker refcounts and iobj_put instead (but that's not
> something I would be betting on).

See above; I think the ref counting needs to be the other way
around: writeback needs to take an active ref to prevent eviction
from a nested iput() call from the filesystem...


-- 
Dave Chinner
david@fromorbit.com
