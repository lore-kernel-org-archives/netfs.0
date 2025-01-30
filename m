Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E41F1314
	for <netfs@lists.linux.dev>; Thu, 30 Jan 2025 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272996; cv=none; b=IYiUc8fdamxOC6DgdxRTTbMr5JJeN5eyn9kd187SLNyCixfiwQTIEDBPshB19gyjOH9h0IG8Y+TjqkHawZ/HsYu2BHxRJtrNyTH8dVy/Md4Ue1PREEDnMUyXnbcwq479KBbLzBImkJCxnZ3dAoEB8IfXrQsX2nsijfjFqN8/RZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272996; c=relaxed/simple;
	bh=3ZdxPvAfcmQNlIJmdWCIqX/gQrdKdUCtNB+7Kj0py+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVc8P+X7KWn7SRrGo2Tx9k3G8SLLEr1viCnXXmsItP1indqXiKE+amwfvhDii2LBk6Tel8jtu0OHH4rec0Tvua5UeHExxr33KqdOsSKcFfBiyduTqixw+JiUPSMYHeeHJyovqnkym77Zlxgdnd341ipkqb6Hnp1FB2tTY3Boxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=GEvp5KDI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="GEvp5KDI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b662090so26057595ad.1
        for <netfs@lists.linux.dev>; Thu, 30 Jan 2025 13:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738272994; x=1738877794; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9ijuiEZzKjbqvpEPNvRB635Y5i4hqTbnqe3HTPqnhM=;
        b=GEvp5KDIy3Oz9ORUA1e/1nAEJAXHzURAlVXKKtlP/pKZkKfmuyaqyTWAT5qIMD6XCO
         w0NvDiNf3AdmKtxwD63PPVwq4qZeHajHNt1Ufz0BUPjTiK8v+g9YIlGfGcl18hplSqe8
         DECXgpfXpuDPumzPJ3SO275b589mvK7xpQHhab4yoyFywDINDcc2m8FOXFhm7qOMIZB/
         H2CbEAk+QhZ5ZuPFsTG4qIoN4Jbi7zZnHOerAfsy9C7h+pZtMTScggJKpSW54ovJr1Wy
         d7K6HB/rnZGOIuZ6mFZce61Wxj8XpD5wLoZqH3L4Jt6bS/vYZqOKqiByzYGAQKChKGxI
         nBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738272994; x=1738877794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9ijuiEZzKjbqvpEPNvRB635Y5i4hqTbnqe3HTPqnhM=;
        b=oy5CoaawpH05aPtpzFky8B2smXQ5rfdNQ3qlRg2f/inqzUMz9cN00WA6oQ0ogS7dyj
         Ietcwm6o/Ivg8Qj9mXEq9TlU1w2vhWdyTiGLzalr6Hag5tqgFE1Ecj4nqeVILY4nKeka
         ErV0k2C66QqFsGnTZGLK8ZEJVMIjeHxWct1c5TiYSfIr0pn//elH3ec77/gBpc2W98Vo
         ok3DLl2iIjqvXKCgtte9PzLbCsvUYfEa52Az5htD1FqSR0gVw3amK1KGBlkpLjyRudXh
         LpjElj2OH4k6sIO1WGWGwdy9RKVucT6ZzVXQxkTyVj3Dt2St82zC00jszc3X4hIkL+qS
         obaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXewubR5ZqGDkh/1Au1UJfOFYUMo5LDbcIWHJhvP/Dwv7MdVFdll+zVFteKDRCMlbYNFB2Stg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzU+q2wV0Oki9oSuuFvxH38Hn4nfWphG48Qgk/AtrtazWlAJ34C
	T8XgfBxfs5ILKNQZLFVAHTgMrxKAHm1KE4YZkTT6P3pcmDvp1emW21AkAtRtzsc=
X-Gm-Gg: ASbGnct8wpBoHg3SlaqsPe3DHQWXV6JYY4v1lFmVgQEg1hTp7eEqfIiKgpOYSHNzEwY
	LVku/phP09nThRMmPSuFjr1RfdlFZf+dGk7QClckR+UI761e8PVv2Gd+px1peVgJZhVgDzorG1j
	Fwfd/9Tl9IId6S+/Bpe1ORLDmKsHVC7LlqmD++r7Yv4GTaj2bWLaG8h2wWauJsufgQBbryWTE/u
	yyG2KraFpvl4Jtmbuqv3re+3fsYbx3dO1hhlsXuhT4QwI5RDRsW9niFTCrRfDEkmyG0mRQ/OgUN
	VwJzIxH6cv0P9eiMtXK8qWzBI9h+tkTLorcnsP3RKu8uBmNJo2tHluOuOMUESPcZuCo=
X-Google-Smtp-Source: AGHT+IFi7KP/uFWpdWAegIG7HhkzsEsibzJqO2iNuwK1YAkhLz6wsiYT3eWBWRTxK1zOZlc8uBTEzg==
X-Received: by 2002:a05:6a21:4598:b0:1e1:e2d8:fd1d with SMTP id adf61e73a8af0-1ed7a6b1784mr14087254637.33.1738272994219;
        Thu, 30 Jan 2025 13:36:34 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1cbc8sm1991253b3a.177.2025.01.30.13.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 13:36:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tdcD8-0000000CZwg-00Ha;
	Fri, 31 Jan 2025 08:36:30 +1100
Date: Fri, 31 Jan 2025 08:36:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ted Ts'o <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
	miklos@szeredi.hu, linux-bcachefs@vger.kernel.org, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev
Subject: Re: [PATCH 0/7] Move prefaulting into write slow paths
Message-ID: <Z5vw3SBNkD-CTuVE@dread.disaster.area>
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
 <qpeao3ezywdn5ojpcvchaza7gd6qeb57kvvgbxt2j4qsk4qoey@vrf4oy2icixd>
 <f35aa9a2-edac-4ada-b10b-8a560460d358@intel.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f35aa9a2-edac-4ada-b10b-8a560460d358@intel.com>

On Thu, Jan 30, 2025 at 08:04:49AM -0800, Dave Hansen wrote:
> On 1/29/25 23:44, Kent Overstreet wrote:
> > On Wed, Jan 29, 2025 at 10:17:49AM -0800, Dave Hansen wrote:
> >> tl;dr: The VFS and several filesystems have some suspect prefaulting
> >> code. It is unnecessarily slow for the common case where a write's
> >> source buffer is resident and does not need to be faulted in.
> >>
> >> Move these "prefaulting" operations to slow paths where they ensure
> >> forward progress but they do not slow down the fast paths. This
> >> optimizes the fast path to touch userspace once instead of twice.
> >>
> >> Also update somewhat dubious comments about the need for prefaulting.
> >>
> >> This has been very lightly tested. I have not tested any of the fs/
> >> code explicitly.
> > 
> > Q: what is preventing us from posting code to the list that's been
> > properly tested?
> > 
> > I just got another bcachefs patch series that blew up immediately when I
> > threw it at my CI.
> > 
> > This is getting _utterly ridiculous_.

That's a bit of an over-reaction, Kent.

IMO, the developers and/or maintainers of each filesystem have some
responsibility to test changes like this themselves as part of their
review process.

That's what you have just done, Kent. Good work!

However, it is not OK to rant about how the proposed change failed
because it was not exhaustively tested on every filesytem before it
was posted.

I agree with Dave - it is difficult for someone to test widepsread
changes in code outside their specific expertise. In many cases, the
test infrastructure just doesn't exist or, if it does, requires
specialised knowledge and tools to run.

In such cases, we have to acknowledge that best effort testing is
about as good as we can do without overly burdening the author of
such a change. In these cases, it is best left to the maintainer of
that subsystem to exhaustively test the change to their
subsystem....

Indeed, this is the whole point of extensive post-merge integration
testing (e.g. the testing that gets run on linux-next -every day-).
It reduces the burden on individuals proposing changes created by
requiring exhaustive testing before review by amortising the cost of
that exhaustive testing over many peer reviewed changes....

> In this case, I started with a single patch for generic code that I knew
> I could test. In fact, I even had the 9-year-old binary sitting on my
> test box.
> 
> Dave Chinner suggested that I take the generic pattern go look a _bit_
> more widely in the tree for a similar pattern. That search paid off, I
> think. But I ended up touching corners of the tree I don't know well and
> don't have test cases for.

Many thanks for doing the search, identifying all the places
where this pattern existed and trying to address them, Dave. 

> For bcachefs specifically, how should we move forward? If you're happy
> with the concept, would you prefer that I do some manual bcachefs
> testing? Or leave a branch sitting there for a week and pray the robots
> test it?

The public automated test robots are horribly unreliable with their
coverage of proposed changes. Hence my comment above about the
subsystem maintainers bearing some responsibility to test the code
as part of their review process....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
