Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0A3E00B4
	for <netfs@lists.linux.dev>; Tue, 19 May 2026 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178551; cv=none; b=Q7yAJraPcY5MLmHxpEFriOrc2xlXH34LyQ9IODJTLXRaY1TDAA6FgsYQUtKuNlcZBuVu3okKqv/7xpSK+L+UlLh4kso+2RiX+nii47d9M7QQ7CPiNWephDr5OUlT+g5XNFQy6jd+XeeTN6EgoG7PMu8jNK0udhGyzGIBIgoMyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178551; c=relaxed/simple;
	bh=ukNhp2SUe+V00i+CScbinEy01SmNCkigc3dUv72ANDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaAwi87kLsuh+HqgyskMqV/5a7pttRU4nP5yEZFB4BgWmOBwjEy22F5XRdrVJAP3xs7inH24uEE3JOwfTT1+3plPe4d+dkZCnplpK2YuagQaxCfKHj8750LwnHXxh1Y+jbAHjjBFlGE4RxtBQ7Sw2KU1BpTvQVN1GULiJ5YY74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh8QYz50; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh8QYz50"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d734223e4so2006880f8f.0
        for <netfs@lists.linux.dev>; Tue, 19 May 2026 01:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779178548; x=1779783348; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq7q4q44H1XtbreNnGBa/qXoQQzGGv2LByvvEOVI2FM=;
        b=dh8QYz50TEsOAO0VU+ZLhhSfvABKBH1jC/4nuXLCRPmbYRDYxmmVC99gJFkYRY0q0o
         i6Ldg3HJLzLIO2pkSGfTHb62OI2R2bz8FUrj3ofmlQS112CfHJLLz7CyvV7jEzFfb9+3
         lGRnL9mk2cunzjM0aWjJS8h3Kkm7VU5wYbH7oVSmSvv/469wPG2XyfbQC0z0YmgrfjbE
         2IHXj+DN5Afj9Ov69RmBcAzoSz+LpcqzDr+6re9b7H5p0oNhnrFSSWG7MlCCygizV8L0
         +v/Z53jUgt7X+xoS2db+LcVTS3Hr+UM7A8XxSxdf4TIP3agb3zx+D+ellQOroUmKClSl
         gOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178548; x=1779783348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gq7q4q44H1XtbreNnGBa/qXoQQzGGv2LByvvEOVI2FM=;
        b=O0yaes2o5u3wGEnCFQAnX4tCvZZwkVRye2ZqFYsFa46gWdv+tloIgTpWdtn3GFcPkq
         I812tRkM11z9zz5PbkXeaMf2vpTynK6U5UDpSKoon3tZb+xueuyorobkuLFTRzupf3AF
         SDwCmQz0S0cn2MRXJIQp0fusFIWNtvKyYc4f1Zwpk9a8GBB2WHiiZNVDg8yP6WL95X3D
         V2630Iy+TyDa8foFDFhd+OS3U1XARdkVS/MZ/gFUuiceTmILl4f68Fu744U4CBMcDz9J
         ukkbh9pn4woOE1Kh2C8U8Surm/pMZyF3E9/TaeNW00AqP9dX0YLEIv2DXjKW52JO8PC6
         9/LA==
X-Forwarded-Encrypted: i=1; AFNElJ9aMgfrxmVa9rD5eJ44odMY94NWroDCuNNIpYt1USyHbPFA1mxipnjM2N0yhw5DOllf7nbkrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0ngSqqWd7+T1VcvUL8EbZaX5TOQfizF/7oCwavshkplQP0CpU
	SyhMcp2vFayckVP5v8/JGRA/DDuYPHO7Xt45r2Xq8f5pusdIB+zGhMPF
X-Gm-Gg: Acq92OH4KLE5h3qj0o/DIPFjeGkV2IFXpJpB4kSoahKGNNjAHAdMTJ5iUtkW6pHojlx
	E4Aorn+G6vfTm3FSCBECuCkRr7d2VCyQy2bESGaF9ZdmZ5Eo58XnqJpZMHN3gJu3QeBdGEotaI5
	zVLdXPq9HQ3qOo8AKb77XJp+4YsZzfrKhrDxzCB0NCEDDd08mWSIC2yvUTtXuK6dBhARvJ51hC1
	FdcJqOZN6KuNbC7yIRHKVfON7tdXV+Si0eU8hcpRFs6K8RU7bk4Y+is1leNZY186HfvTm+ztM5Z
	9F/Urh42dTXlTKIribcgJW0reFzRtfMylBtuhSloGqQTCMb3hqMK73BVulb9k/G5TCWyRBrxdhu
	T3AfFKXo2+N5vhsiqoO9nlU5KKDEvMD3986Me4Dooc7d+Uguptk6rtQdtY9k7xIbhmyTfVcaiFZ
	ls2komNP7uoPj9dK5PSM/O6kVzapdZRAFNrPR6CSKQcpafrOQI7M5D42DkpB8a1KHC
X-Received: by 2002:a5d:4577:0:b0:450:b883:dd3c with SMTP id ffacd0b85a97d-45d9352412cmr26263969f8f.20.1779178547828;
        Tue, 19 May 2026 01:15:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e7c22d8b7sm14602897f8f.6.2026.05.19.01.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:15:47 -0700 (PDT)
Date: Tue, 19 May 2026 09:15:45 +0100
From: David Laight <david.laight.linux@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Matthew Wilcox
 <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Paulo
 Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>, Leon Romanovsky
 <leon@kernel.org>, Steve French <sfrench@samba.org>, ChenXiaoSong
 <chenxiaosong@chenxiaosong.com>, Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Dominique Martinet
 <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>, Trond
 Myklebust <trondmy@kernel.org>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/21] netfs: Keep track of folios in a segmented
 bio_vec[] chain
Message-ID: <20260519091545.171c4b85@pumpkin>
In-Reply-To: <20260518222959.488126-1-dhowells@redhat.com>
References: <20260518222959.488126-1-dhowells@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 23:29:32 +0100
David Howells <dhowells@redhat.com> wrote:

> Hi Christian,
> 
> Could you add these patches to the VFS tree for next?
> 
> The patches get rid of folio_queue, rolling_buffer and ITER_FOLIOQ,
> replacing the folio queue construct used to manage buffers in netfslib with
> one based around a segmented chain of bio_vec arrays instead.  There are
> three main aims here:
> 
>  (1) The kernel file I/O subsystem seems to be moving towards consolidating
>      on the use of bio_vec arrays, so embrace this by moving netfslib to
>      keep track of its buffers for buffered I/O in bio_vec[] form.
> 
>  (2) Netfslib already uses a bio_vec[] to handle unbuffered/DIO, so the
>      number of different buffering schemes used can be reduced to just a
>      single one.
> 
>  (3) Always send an entire filesystem RPC request message to a TCP socket
>      with single kernel_sendmsg() call as this is faster, more efficient
>      and doesn't require the use of corking as it puts the entire
>      transmission loop inside of a single tcp_sendmsg().
> 
> For the replacement of folio_queue, a segmented chain of bio_vec arrays
> rather than a single monolithic array is provided:
> 
> 	struct bvecq {
> 		struct bvecq		*next;
> 		struct bvecq		*prev;
> 		unsigned long long	fpos;
> 		refcount_t		ref;
> 		u32			priv;
> 		u16			nr_segs;
> 		u16			max_segs;
> 		enum bvecq_mem		mem_type:2;
> 		bool			inline_bv:1;
> 		bool			discontig:1;

There doesn't seem to be any point using bitfields.
There is a massive hole here anyway.

> 		struct bio_vec		*bv;
> 		struct bio_vec		__bv[];
> 	};
> 
> The fields are:
> 
>  (1) next, prev - Link segments together in a list.  I want this to be
>      NULL-terminated linear rather than circular to make it possible to
>      arbitrarily glue bits on the front.

Do you ever need to follow the list backwards?
If not making prev point to the pointer to the entry (probably a tailq?)
makes the logic simpler (and safer) because you can remove an item without
knowing whether it is the head or which list it is on.

> 
>  (2) fpos, discontig - Note the current file position of the first byte of
>      the segment; all the bio_vecs in ->bv[] must be contiguous in the file
>      space.  The fpos can be used to find the folio by file position rather
>      then from the info in the bio_vec.

Should fpos be off_t (or u64) rather than 'long long' (they are all the
same underlying type).

>      If there's a discontiguity, this should break over into a new bvecq
>      segment with the discontig flag set (though this is redundant if you
>      keep track of the file position).  Note that the beginning and end
>      file positions in a segment need not be aligned to any filesystem
>      block size.

At this point you lose me :-)

-- David
