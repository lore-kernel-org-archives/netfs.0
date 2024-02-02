Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5A146913
	for <netfs@lists.linux.dev>; Fri,  2 Feb 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889476; cv=none; b=TfkscRAQTPGH3U2QK2h7DOHOWTu6SK/+0sOMoJwbhzf+jR0J14n3ezJjpF8HyE0P22A94dwpAcE39/MNfrc3MoEdYmBIS0kdE6ZWVjL3UGuBu1++WfXej4V6feOkFvF74cT/93VM11rWWyFiZac866sP6JYGc9df4R3esQDZjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889476; c=relaxed/simple;
	bh=sxm7dDN0Q3Z9wrp/tfWJA/32uHwU5Vbp+ZQAi3XelQ8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=QGzYzP/jlTFFkgXFE9Ul3U5qWeZxdjqjwUcdau0REmUz1Ek6p3INjBmXfwwAXQC/1mX84psmrMNd1+pWDt5pniluWck6OLoSjDwQjSXgsAX4ad79sRiXNXatJ5BEKNyHYaJaQhc8vwWdpt6m7PlYcwQkfT+nvTyDHuS9TFUdBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UDvKmU9l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDvKmU9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706889474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5fucXjs3Pug8NIrqUChZMc42UrlJY9vx+TjWlUCGhf8=;
	b=UDvKmU9l7C1gg+LkEy6COyzJ+wYwHzK+HAHfTwvu5He8GQUVNbzBmw1e89r8fuAmOxH6M0
	NKmMS0gQFaHTrjxEyq8Cs2vYQfL5/rXGY1bb6lg1h5b5ZkxDoxCsw3nNH00a1Nbxfy75Ao
	vCOdjGavwLFJnEE/PTtx7V2R/ykUqwM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-bL1KB8JvMPeLsTPWVeBEKw-1; Fri, 02 Feb 2024 10:57:50 -0500
X-MC-Unique: bL1KB8JvMPeLsTPWVeBEKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53A03185A785;
	Fri,  2 Feb 2024 15:57:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7F6071C060AF;
	Fri,  2 Feb 2024 15:57:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zbz8VAKcO56rBh6b@casper.infradead.org>
References: <Zbz8VAKcO56rBh6b@casper.infradead.org> <2701740.1706864989@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, lsf-pc@lists.linux-foundation.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2761654.1706889464.1@warthog.procyon.org.uk>
Date: Fri, 02 Feb 2024 15:57:44 +0000
Message-ID: <2761655.1706889464@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Matthew Wilcox <willy@infradead.org> wrote:

> So my modest proposal is that we completely rearchitect how we handle
> swap.  Instead of putting swp entries in the page tables (and in shmem's
> case in the page cache), we turn swap into an (object, offset) lookup
> (just like a filesystem).  That means that each anon_vma becomes its
> own swap object and each shmem inode becomes its own swap object.
> The swap system can then borrow techniques from whichever filesystem
> it likes to do (object, offset, length) -> n x (device, block) mappings.

That's basically what I'm suggesting, I think, but offloading the mechanics
down to a filesystem.  That would be fine with me.  bcachefs is an {key,val}
store right?

> > Further to this, we have at least two ways to cache data on
> > disk/flash/etc. - swap and fscache - and both want to set aside disk space
> > for their operation.  Might it be possible to combine the two?
> > 
> > One thing I want to look at for fscache is the possibility of switching
> > from a file-per-object-based approach to a tagged cache more akin to the
> > way OpenAFS does things.  In OpenAFS, you have a whole bunch of small
> > files, each containing a single block (e.g. 256K) of data, and an index
> > that maps a particular {volume,file,version,block} to one of these files
> > in the cache.
> 
> I think my proposal above works for you?  For each file you want to cache,
> create a swap object, and then tell swap when you want to read/write to
> the local swap object.  What you do need is to persist the objects over
> a power cycle.  That shouldn't be too hard ... after all, filesystems
> manage to do it.

Sure - but there is an integrity constraint that doesn't exist with swap.

There is also an additional feature of fscache: unless the cache entry is
locked in the cache (e.g. we're doing diconnected operation), we can throw
away an object from fscache and recycle it if we need space.  In fact, this is
the way OpenAFS works: every write transaction done on a file/dir on the
server is done atomically and is given a monotonically increasing data version
number that is then used as part of the index key in the cache.  So old
versions of the data get recycled as the cache needs to make space.

Which also means that if swap needs more space, it can just kick stuff out of
fscache if it is not locked in.

> All we need to do is figure out how to name the lookup (I don't think we
> need to use strings to name the swap object, but obviously we could).  Maybe
> it's just a stream of bytes.

A binary blob would probably be better.

I would use a separate index to map higher level organisations, such as
cell+volume in afs or the server address + share name in cifs to an index
number that can be used in the cache.

Further, I could do with a way to invalidate all objects matching a particular
subkey.

David

