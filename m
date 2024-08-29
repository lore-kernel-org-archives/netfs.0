Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C51CA85;
	Thu, 29 Aug 2024 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899679; cv=none; b=UXTetcTcRHvjHgUodardTZISOxJZz82bP2lOPbAROTDs+eNXLIfwj8c/1vrOmgq3rJfVjUJRaVn7euCwxYckFp2WVj8mo8IrlDy5NeCFUg8bz1Yxgf8UkRn89oFNxdKRWTDOjWMeHK88XJbVwg1xhiEOJJJv7NikjznLVVmndZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899679; c=relaxed/simple;
	bh=yZBj6yB+vdP8EWPB8Ad9fGdRR9EORM7UbpU9Y+Lq7WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acGFilNVWQ0uWQ11M9jEl13zbPzu5bd/Glm3GU+TuM+OlkE6ged7HljzojZZV4dfqpSnpaLson/P6dKjm+WQO9bQCx54+lf10tmAiV7oOqJ+UAiQFllDB3bXwMfyugBDQGsQksFHQW1XFuLBqSwj777mp0DiW9tlCexrmLaYjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCi2jXOI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCi2jXOI"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334adf7249so181980e87.3;
        Wed, 28 Aug 2024 19:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724899676; x=1725504476; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8nW60xbKKK3BMmTEpx1vfAUyDbucJTsTqvhOF4FZ8U=;
        b=TCi2jXOIUVty5Emv5/rtm72wdSjxnK5lwtvYOl3MIqBd5omnZpFKPrVyoT5/yxf/Bl
         y+8vj+bYiBecwS1Hhksmozr0EYtqbpNj/oaDNBJ4TfRktbp0jPb76gCM4wALVRiFIEi8
         3YFF65uSql9RC5Smokam42lAthvZNtQzqOYnaYEa8H8Y7F4Uicf+BOChQkLs6FM5OAMr
         uA+qSICpx6QkVPze6kk4zQo+J5kbZ4P59tPleSRoH2EC/sDZmJlr81Y8ZMBkabiVVDi0
         NjoBytcuWI8eIbPPhgqqVb/dzPy5RURu7/rMHdVC54upMxvZshVOrpjtTpA0NlHd0AsU
         wrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724899676; x=1725504476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8nW60xbKKK3BMmTEpx1vfAUyDbucJTsTqvhOF4FZ8U=;
        b=rn/olq5G4CqAA0Qz0hxKjlEUrQAjOwAl7c0SwsVEIVbnS4l9kToBwpI7iyw+mSZmHy
         tqSJYvT2gmTs/IgRicpemA7vnGQWLYSZwrmJTbagCzossWtQP7kI5Kv8BizX99nB7pQh
         B0n0W7KY2G7Q8sg6MtwusavoI26YE7BNm6D3iae3w45+2eoQrqTuMIW0aijovqtl5d9A
         eMOXm/2cXITqgP/EvtQPnQ4P92aHKArSO2FtEJwjj10SQxpKDr+DDD2dMkqlK5eq1pjD
         P0ZiGn1N63eq9/CJWyS8vuxIPiSoBn891FkkZoPe4VVYG/u9wdSHBc0Fjezd8c88GhVz
         Zi4g==
X-Forwarded-Encrypted: i=1; AJvYcCVbIGv1A9+m5T5g6GZkNWu/xboMh7uJCHUzLbyXESQqUErrNYlmrWnBsWht1tGtlvUP40Xctw==@lists.linux.dev, AJvYcCWXActOGvqUXl+9nSZOeSq9WjjTDLptAyEv688zuhT0JrcyOv5XU7mjRt6t6BZb/6rFGXd2xw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyflD0ptlgmQ5XV+9ZFaSxA+KsZdb19AQqXAMdllEm7pwsA0dGP
	pJXdkzTBQCBoh/1/Vpqb1OgE6/FM1FMSQGpazppLGlkcQZyDpIVxfhh7p9mDBciWyX4QHeosMf8
	wLXE74CBiReaGWHIO8Y2Slg6uRqw=
X-Google-Smtp-Source: AGHT+IFw6YFPE4uQg6imkFHXMbxtDADWvwTRJd5bZLVgOFxAE0atjLaGwN/Y3Vs2U2TCttK/XyhsIPdmUPLmGEsItEg=
X-Received: by 2002:a05:6512:1055:b0:52c:db0a:a550 with SMTP id
 2adb3069b0e04-5353e5aae01mr710771e87.42.1724899675197; Wed, 28 Aug 2024
 19:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240828210249.1078637-1-dhowells@redhat.com>
In-Reply-To: <20240828210249.1078637-1-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 28 Aug 2024 21:47:43 -0500
Message-ID: <CAH2r5muvO8+Es4Y8d=VtWEp-vcC62TYEZc3W1Y0r+6ro6d9yxQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm, netfs, cifs: Miscellaneous fixes
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

testing is going fine so far with David's series ontop of current mainline

(I see one possible intermittent server bug failure - on test
generic/728 - but no red flags testing so far)

http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/207

On Wed, Aug 28, 2024 at 4:03=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Christian, Steve,
>
> Firstly, here are some fixes to DIO read handling and the retrying of
> reads, particularly in relation to cifs:
>
>  (1) Fix the missing credit renegotiation in cifs on the retrying of read=
s.
>      The credits we had ended with the original read (or the last retry)
>      and to perform a new read we need more credits otherwise the server
>      can reject our read with EINVAL.
>
>  (2) Fix the handling of short DIO reads to avoid ENODATA when the read
>      retry tries to access a portion of the file after the EOF.
>
> Secondly, some patches fixing cifs copy and zero offload:
>
>  (3) Fix cifs_file_copychunk_range() to not try to partially invalidate
>      folios that are only partly covered by the range, but rather flush
>      them back and invalidate them.
>
>  (4) Fix filemap_invalidate_inode() to use the correct invalidation
>      function so that it doesn't leave partially invalidated folios hangi=
ng
>      around (which may hide part of the result of an offloaded copy).
>
>  (5) Fix smb3_zero_data() to correctly handle zeroing of data that's
>      buffered locally but not yet written back and with the EOF position =
on
>      the server short of the local EOF position.
>
>      Note that this will also affect afs and 9p, particularly with regard
>      to direct I/O writes.
>
> And finally, here's an adjustment to debugging statements:
>
>  (6) Adjust three debugging output statements.  Not strictly a fix, so
>      could be dropped.  Including the subreq ID in some extra debug lines
>      helps a bit, though.
>
> The patches can also be found here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Dnetfs-fixes
>
> Thanks,
> David
>
> David Howells (6):
>   cifs: Fix lack of credit renegotiation on read retry
>   netfs, cifs: Fix handling of short DIO read
>   cifs: Fix copy offload to flush destination region
>   mm: Fix filemap_invalidate_inode() to use
>     invalidate_inode_pages2_range()
>   cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target
>     region
>   netfs, cifs: Improve some debugging bits
>
>  fs/netfs/io.c            | 21 +++++++++++++-------
>  fs/smb/client/cifsfs.c   | 21 ++++----------------
>  fs/smb/client/cifsglob.h |  1 +
>  fs/smb/client/file.c     | 37 ++++++++++++++++++++++++++++++++----
>  fs/smb/client/smb2ops.c  | 26 +++++++++++++++++++------
>  fs/smb/client/smb2pdu.c  | 41 +++++++++++++++++++++++++---------------
>  fs/smb/client/trace.h    |  1 +
>  include/linux/netfs.h    |  1 +
>  mm/filemap.c             |  2 +-
>  9 files changed, 101 insertions(+), 50 deletions(-)
>
>


--=20
Thanks,

Steve
