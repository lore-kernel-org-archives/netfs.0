Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D054527D77B
	for <netfs@lists.linux.dev>; Tue, 24 Jun 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778388; cv=none; b=UHxe/rkDh9wmk2vTNPIxUs40dSDiPlWUEXLKelKWwBbbpu67JgwxDfBAfFNo+K4r0T9n6owf1uZDPl6g7OOakEr7Hnqn14MSJJkGYXJRO0vTRDLQj14RTrfL1jzRXLT+ik5sGjrIZb+o2f1W8nV6eCb7DHtXxVbAVJKU/+VMADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778388; c=relaxed/simple;
	bh=ujmUW4TpX4BPTQx8jMF9izuhuYiV8aAka42RsWenZYA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=jxPqZdR6ai+NwWl6sSdJ19R5g7xsC/PijKytDS5jpDp4CUyGui801ri3i7Uu8PHWieCkg1ss46rVpHAyX+s3laGyWPca8+E3FQODilcNVnXjyeIlTk54F5u9+XMdC6/8hXqRuqUuK0RuABonURMAqP7ZuO1jrjG/H4NrCS+BtaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B914zs9j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B914zs9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750778385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASKoaAYO8KO37B94uQoggiUNWPKZVvmpeFQF3C5jCcY=;
	b=B914zs9jLY9hOqso4yF14uVDAx+Nuq3Ok9GMxawQ4DnkH79PaI74srznFHRat8opdTsOqB
	FfyP24Wvic0cHDTpWFP9CN976Z38ibQqh+zvAjzRCZfw7MFpw8IglE4o7J2KierwGtBK0m
	QrzAz5hLdgQ2nnGOpDdMOODHgF3VxU4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-AZIavt47PEOHKsgbBg-wpQ-1; Tue,
 24 Jun 2025 11:19:44 -0400
X-MC-Unique: AZIavt47PEOHKsgbBg-wpQ-1
X-Mimecast-MFC-AGG-ID: AZIavt47PEOHKsgbBg-wpQ_1750778383
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C94CC180123A;
	Tue, 24 Jun 2025 15:19:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACD1419560A3;
	Tue, 24 Jun 2025 15:19:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <619bca7a-d89c-4262-8c05-1ac536db0a6e@cern.ch>
References: <619bca7a-d89c-4262-8c05-1ac536db0a6e@cern.ch> <31cd8f34-1b37-4062-925a-baedec8f2f79@cern.ch> <963373.1750426130@warthog.procyon.org.uk>
To: Benjamin Fischer <benjamin.fischer@cern.ch>
Cc: dhowells@redhat.com, netfs@lists.linux.dev
Subject: Re: Cachefiles slowdown caused by SEEK_HOLE
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 24 Jun 2025 16:19:29 +0100
Message-ID: <1157517.1750778369@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fWXifFRPQeXd7vWpuEGwH-WiTiulhMctPJAtFOPxIaQ_1750778383
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1157516.1750778369.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Benjamin Fischer <benjamin.fischer@cern.ch> wrote:

> >   (4) Setting xattrs is slow as each one is a synchronous journalled
> >       metadata operation.
> This could be resolved by avoiding xattrs altogether and instead using th=
e
> (already) required support for sparse files: One could store the file
> contents of the file at a (fixed) offset into the file (e.g. 1GiB) and us=
e
> the space before this to store the bitmap (or whatever other information =
is
> needed for the cache). Even with a block size of 4KiB and offset of 1GiB
> would still accommodate a bitmap for file up to 32TiB which likely covers
> the vast majority of use cases. Would this be feasible? Or maybe has this
> approach been already rejected?

Not completely rejected.  It's just that there's a bunch of different desig=
n
compromises one can make.  One of the original design decisions I made was
that I didn't want to restrict the amount of filespace one could cache; wit=
h
your suggestion, you lose the last 32TiB of the 8EiB you can access.  I don=
't
know if this is a problem.

Also, at the time I first did this, you couldn't do DIO to/from kernel spac=
e.

That said, probably the single most effective change would be to dispense w=
ith
mapping the contents of a file if I know I have all of it in the cache.  By
far and away, the most common write pattern is { open(O_TRUNC); write();
write(); write(); close(); }.  Noting this with a flag in the main xattr on=
 a
file would allow all the seeking to be skipped.

> >   (5) We have metadata integrity issues if we want to evict an bitmap f=
or
> >       memory reclaim.  We need to flush (and maybe sync) data from a
> >       separate filesystem before writing the xattr.  This might not be =
so
> >       bad as the main metadata xattr on a cachefile has a flag in it th=
at
> >       says the object is under modification, so we only need to flush,
> >       sync and write back all the bitmaps before altering that flag - a=
nd
> >       this can be done in the background.

> I don't quite understand the intricacies of the race conditions you refer=
 to
> here, but I imagine this might also be simplified by storing the
> bitmap/metadata within the file itself.

The problem is that when we reconnect a network fs file with a cache object=
,
we have to know that the cache object is in a good state.  Imagine a scenar=
iou
in which the machine crashes while I/O is in progress to the netfs and the
cache.  We could just blow the cache away entirely; but situations have bee=
n
encountered where that really sucks.

What I currently do is use an xattr to mark a cache object as being "dirty"=
.
When that object is opened, the dirty flag is set before we do any other
modifications to it.  When the object is closed, I have to flush all
outstanding changes and metadata changes to it before I can remove the dirt=
y
mark.

If I don't do that, and the system crashes, say, between the dirty mark bei=
ng
set and the changes hitting the disk, we can end up with an unknowingly
corrupt cache object.

The xattr with the dirty mark also holds coherency info that needs updating=
.
For AFS, that's the data version number; for NFS, that's the ctime, mtime a=
nd
change attribute.

Storing the bitmap in the file does simplify things in a couple of ways: I =
can
trivially read/write parts of it (with DIO, even) and fdatasync() will flus=
h
the bitmap content in addition to the data.

> > An alternative method that may prove fruitful is to explore the way
> > OpenAFS does caching: by having a bunch of, say, 256KiB cache files and=
 an
> > index that says which part of what network file is stored in what cache
> > file.
>
> Such a implementation would probably be useful, but just like using an ex=
tend
> list/tree instead of a bitmap, it is far from straight forward and as suc=
h
> prone to implementation & tuning difficulties.

Yeah... there's no single right answer.

