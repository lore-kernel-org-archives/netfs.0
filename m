Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22530405F9
	for <netfs@lists.linux.dev>; Thu, 29 Feb 2024 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235087; cv=none; b=C5ZRsc2SlFPH4j3oIpTO6fCJO9B7mv5EGFtEADUwcuSYfW5UIqwQ5GZnfjeOY9uU/0qTdpFvrp0osqKDRmDwndVq6ePw+iUslVHVNJ7/GCaqDLWx4Ehv9BA4bH+oA3b5CMDBvyQfXZPRLoskP5r3kuaEvtQGmpUwj0gjnbUy7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235087; c=relaxed/simple;
	bh=vWkgBUl9V8zzq+Ocdi7IrYcPtFJi2zw+v1JOHzEqo48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJWfyAOxWd0iYRUvxVIkV5puP3QjAUdZmdXsN2sEv/KRbqm6yjlckzYgGXeurAzL6inZ102nD+5FjK923G0lKpCMI5z00XbYQE3S4FRkwCx+sq+S8cUXn4PEZuFM5Y+dFgC55V+HSmkfH9q5+ZB2E5csN+h/dTmrTuR2ouljsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXo5rcGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXo5rcGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E6AC433F1
	for <netfs@lists.linux.dev>; Thu, 29 Feb 2024 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709235086;
	bh=vWkgBUl9V8zzq+Ocdi7IrYcPtFJi2zw+v1JOHzEqo48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PXo5rcGNcGPORD2C593HQ0++cr2DhCHUXriqji8v1dGSX4O7i9yF/1/SetT39pUub
	 T5LoFp21eV0B7HnNJQV7eZpwzOJd/pNbt4pwguBCsT84dJg7y7HSpnoYDro2gz3Zya
	 1I460YRWIIZyFk2NRCqTArOo5PHBeZGXKjWpXHjGjLbdfu4duyPqUBaeTED2FBKcQm
	 hu+oRvo6mu5R+J02tbmCq21pua0yX1+YmMN3RtTUPzsB7BbeRXE0B6iB/D7nEYX3+6
	 ymOs47S1Bkey9c8j2FTpkDfnmk1hiZX4To9DBQcyQ/VL5sI2uktqM4SmWiBfBCovQq
	 s4S7hRC6gJ2rA==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-365c80d1114so4137015ab.3
        for <netfs@lists.linux.dev>; Thu, 29 Feb 2024 11:31:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDBrjBypYWvIs+s0WjeWIHp0idocCxVmQx+X0d3mO1Q31IWpL8VdjkZUUgicn089jBvHc0FOgvVcOaeLr1AJgcu9nUFaY=
X-Gm-Message-State: AOJu0YwFyP4gYMPBTr43bA7E/Q5B56GfgS4gtwAalCr3ltHGu08G+YxP
	ZnVzOfvQr8s0PWwXCtDU/Jn7hzl/eKOlnr8qfznW5c7vCcF56S2wZqi5W3bWcYZumOADSk8UZJn
	hI+qXAlSZU7p+keQrEQRjef/w3leLwlR4Yo5M
X-Google-Smtp-Source: AGHT+IH6o1VRdbbDzmd2S/3gNApCVNErtkJIbssEMM6NS3pyBNfgv/MJuH86kMdZTJwgpBlSB1Gkw+XY38lp47zNsTc=
X-Received: by 2002:a92:c245:0:b0:365:1b7c:670 with SMTP id
 k5-20020a92c245000000b003651b7c0670mr11943ilo.8.1709235086020; Thu, 29 Feb
 2024 11:31:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2701740.1706864989@warthog.procyon.org.uk> <Zbz8VAKcO56rBh6b@casper.infradead.org>
In-Reply-To: <Zbz8VAKcO56rBh6b@casper.infradead.org>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 29 Feb 2024 11:31:12 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNtbE3qEf=of1KQj=tNobWCz4A48FpVRUU6osvtt88jPw@mail.gmail.com>
Message-ID: <CAF8kJuNtbE3qEf=of1KQj=tNobWCz4A48FpVRUU6osvtt88jPw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
To: Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>, lsf-pc@lists.linux-foundation.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Fri, Feb 2, 2024 at 6:29=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, Feb 02, 2024 at 09:09:49AM +0000, David Howells wrote:
> > The topic came up in a recent discussion about how to deal with large f=
olios
> > when it comes to swap as a swap device is normally considered a simple =
array
> > of PAGE_SIZE-sized elements that can be indexed by a single integer.
> >
> > With the advent of large folios, however, we might need to change this =
in
> > order to be better able to swap out a compound page efficiently.  Swap
> > fragmentation raises its head, as does the need to potentially save mul=
tiple
> > indices per folio.  Does swap need to grow more filesystem features?
>
> I didn't mention this during the meeting, but there are more reasons
> to do something like this.  For example, even with large folios, it
> doesn't make sense to drive writing to swap on a per-folio basis.  We
> should be writing out large chunks of virtual address space in a single
> write to the swap device, just like we do large chunks of files in
> ->writepages.

I have thought about your proposal after the THP meeting. One
observation is that the swap write and swap read has some asymmetries.
For swap read, you always know which vma you are reading into.
However, the swap write that is based on the LRU list,
(shrink_folio_list) does not have the vma information in hand.
Actually the same folio might map by two different processes. It would
need to do the rmap walk to find out the VMA. So organizing the swap
write around VMA mapping is not convenient for the LRU reclaim write
back case.

Chris


> Another reason to do something different is that we're starting to see
> block devices with bs>PS.  That means we'll _have_ to write out larger
> chunks than a single page.  For reads, we can discard the extra data,
> but it'd be better to swap back in the entire block rather than
> individual pages.
>
> So my modest proposal is that we completely rearchitect how we handle
> swap.  Instead of putting swp entries in the page tables (and in shmem's
> case in the page cache), we turn swap into an (object, offset) lookup
> (just like a filesystem).  That means that each anon_vma becomes its
> own swap object and each shmem inode becomes its own swap object.
> The swap system can then borrow techniques from whichever filesystem
> it likes to do (object, offset, length) -> n x (device, block) mappings.
>
> > Further to this, we have at least two ways to cache data on disk/flash/=
etc. -
> > swap and fscache - and both want to set aside disk space for their oper=
ation.
> > Might it be possible to combine the two?
> >
> > One thing I want to look at for fscache is the possibility of switching=
 from a
> > file-per-object-based approach to a tagged cache more akin to the way O=
penAFS
> > does things.  In OpenAFS, you have a whole bunch of small files, each
> > containing a single block (e.g. 256K) of data, and an index that maps a
> > particular {volume,file,version,block} to one of these files in the cac=
he.
>
> I think my proposal above works for you?  For each file you want to cache=
,
> create a swap object, and then tell swap when you want to read/write to
> the local swap object.  What you do need is to persist the objects over
> a power cycle.  That shouldn't be too hard ... after all, filesystems
> manage to do it.  All we need to do is figure out how to name the
> lookup (I don't think we need to use strings to name the swap object,
> but obviously we could).  Maybe it's just a stream of bytes.
>
