Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB727E040
	for <netfs@lists.linux.dev>; Fri, 20 Jun 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426139; cv=none; b=X7x/kWG4PHX+bQB6ThpuhuOkjJSKw5HN3wrwa8769v4Ke1tcqsNhO4wiiTDEHMnHbZ2xD108x9Ens8WyrGXJHt1tN0qMhR8omD2MVYmyXUlXAXTkDtsiSeAu+VFKsfcCo4iATJNnnpNMkRSq3LYUJzHAJZ+2GZwR89xZatOH0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426139; c=relaxed/simple;
	bh=p9nqgV2Yk3qqI+tS1tXXJFfpzkGtCSB8xhv2X3G+XU8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=j6el/gfD3oVuy7ETPiaAKP9/lijzb2/Yr4OWkRDqYM3mhzG1qOSQgC7fuxZM3gtDOHUfZPcfUHa2JIfh3L2VqNysdMu7/tx+vt4ZK5vs58AQ2IM5W09TAvqRvOhbe9ZdrRZWPbm0FDxmJU8oK4uQHWRHZ9N7zsOtav1pWx7EwcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUQRJS1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUQRJS1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750426136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYTsB2Kt5G+NImFKUvGNl1mSQTLSuY6AlzT8njbMVGA=;
	b=DUQRJS1AjrTLhHUxwIz2Y2/2rm1fAa9QpN4tmPgMkm2GFS5VG9y9rNY2r1yNh3oxoCpuYT
	WkKitEatjFQGbnvA9CbzUu+df2fiua2KsuWqHcVQZYwpFWGQId5rkZ+kZ1rQ4be+/cHEto
	mD6d9HRa6J8r6kqp5YS1Bnyl2w/5SII=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-VhUXDo87PpuEoRh7yKtKPw-1; Fri,
 20 Jun 2025 09:28:53 -0400
X-MC-Unique: VhUXDo87PpuEoRh7yKtKPw-1
X-Mimecast-MFC-AGG-ID: VhUXDo87PpuEoRh7yKtKPw_1750426132
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B1541956080;
	Fri, 20 Jun 2025 13:28:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.211])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CB8219560A3;
	Fri, 20 Jun 2025 13:28:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <31cd8f34-1b37-4062-925a-baedec8f2f79@cern.ch>
References: <31cd8f34-1b37-4062-925a-baedec8f2f79@cern.ch>
To: Benjamin Fischer <benjamin.fischer@cern.ch>
Cc: dhowells@redhat.com, netfs@lists.linux.dev
Subject: Re: Cachefiles slowdown caused by SEEK_HOLE
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 20 Jun 2025 14:28:50 +0100
Message-ID: <963373.1750426130@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ddrnlI-DSu7s44XCAmf2yzbY-JB7lzVpu0oSjdVZ4TA_1750426132
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-ID: <963372.1750426130.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

> I've observed that when using cachefiles there is extreme performance
> degradation when the cache backing file (i.e. in /var/cache/fscache) is
> severely fragmented.

Yeah, I can imagine.  One of the many things on my TODO list is to replace
this in some way.  Unfortunately, the ext4 and xfs maintainers think it's n=
ot
a good idea to rely on the backing filesystem metadata as the backing fs is=
 at
liberty to punch out blocks of zeros or insert bridging blocks in order to
better optimise the fragments list.  The former would give a false negative=
,
causing us to have to go get the block again and, worse, the latter would g=
ive
a false positive, making us think we have data that we don't.

> For example, we have a 40GiB file in a NFS 4.2 mount (rsize of 1 MiB), th=
at
> fully resides in the local (fs)cache and reading starts at ~16MB/s. Readi=
ng
> the backing file directly can be done at ~500MB/s - the hardware limit. T=
he
> backing file has ~200k extends and resides on an etx4 formatted SSD.
>=20
> Using perf record, I found the culprit to be iomap_seek_hole (caused by
> cachefiles_prepare_read) and its descendants, which account for 98% of cp=
u
> time, which in turn is almost 100% of the wall time. So the root cause is=
 that
> SEEK_HOLE is too slow when it has to traverse lots of extends, at least f=
or
> ext4.

Ouch.  Yeah, we have to do a SEEK_HOLE *and* a SEEK_DATA to define the limi=
ts
on a piece of occupied filespace - and that sucks.  I might be able to use
FIEMAP, and certainly caching the result of the seeks ought to be fine... b=
ut
for the small matter of the aforementioned possibility of the backing fs
screwing with things.

> I've verified the time it takes to SEEK_HOLE manually and found consisten=
t
> results (66ms) which behave as expected: the further one starts into the =
file
> the faster the seek gets. This is also reflected in the read rate through
> cachefiles, which grows in a 1 over "remaining file size" manner until it
> achieves the hardware-limited speed near the end of the file.

It's probably reflects the way the extent list is stored.

> This should also affect all other filesystems, that search for holes in s=
uch a
> linear fashion - which I imagine is most, if not all, of them. These slow=
downs
> will mostly affect fully cached files, exactly the case where one would
> expect/need the best performance. They are also exasperated by smaller rs=
ize
> or when cache read/fill patterns induce a lot of fragmentation. Therefore=
 I
> think it sensible to address this issue.
>=20
> My naive impression is that using fiemap should help mitigate the impact.=
 One
> could still fall back on existing SEEK_DATA/SEEK_HOLE behavior, in case f=
iemap
> is unavailable.
>=20
> While I wouldn't mind (attempting) to contribute the necessary code, I'm =
not
> too sure that my non-existent kernel development skills would actually be
> helpful.
>=20
> In any case, I wanted to bring this to your attention such that you at le=
ast
> may ponder about it.

I have a solution that used to work (give or take the odd bug in it) until =
I
was persuaded to shift to creating netfslib and still have the code hanging
around somewhere (it needs updating).

Here:

=09https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dfscache-iter-dir

and, in particular, this patch:

=09cachefiles: Implement a content-present indicator and bitmap

The way it works is that you define a 'fragment size' for the cache file, s=
ay
256KiB or 2MiB, and then divide the file up into blocks of that size.  A
bitmap is stored in an xattr that indicates the occupancy of those blocks. =
 If
a file is completely stored locally, then we can dispense with the bitmap.

This has a number of limitations:

 (1) We limit the xattr size to 512 bytes to hold down memory usage and, al=
so,
     we can't read/modify parts of an xattr, only whole xattrs.

 (2) Because the xattr is limited in size, there is a limit on the number o=
f
     blocks we can map.  For 256KiB blocks, with 4096 bits in the map, we a=
re
     limited to a maximum of 1GiB.

 (3) We could have multiple xattrs, each covering a different part of the
     file.

 (4) Setting xattrs is slow as each one is a synchronous journalled metadat=
a
     operation.

 (5) We have metadata integrity issues if we want to evict an bitmap for
     memory reclaim.  We need to flush (and maybe sync) data from a separat=
e
     filesystem before writing the xattr.  This might not be so bad as the
     main metadata xattr on a cachefile has a flag in it that says the obje=
ct
     is under modification, so we only need to flush, sync and write back a=
ll
     the bitmaps before altering that flag - and this can be done in the
     background.

 (6) When it comes to the data itself, we have to create or download an ent=
ire
     block in one go in order to cache it (which actually improves the
     performance in some circumstances).  This ought to be easier with
     multipage folios - but the new readahead algorithm adds some irritatio=
ns
     of its own, and we can end up with competing readaheads that cause
     caching to fail at the point where they meet if it doesn't align.

     We don't necessarily have to write back the entire block if we only
     changed, say, one byte.

One reason I haven't progressed much with it is that is at the point of
turning into its own journalling filesystem... and we already have a bunch =
of
those.  Further, the point of cachefiles is that it uses files on an alread=
y
mounted filesystem so that you don't have to have a dedicated blockdev for =
it.

An alternative method that may prove fruitful is to explore the way OpenAFS
does caching: by having a bunch of, say, 256KiB cache files and an index th=
at
says which part of what network file is stored in what cache file.

But if you're up for having a crack at forward porting the bitmap idea, I c=
an
give you some guidance.

David

