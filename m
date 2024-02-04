Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F410799
	for <netfs@lists.linux.dev>; Sun,  4 Feb 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090346; cv=none; b=FD8HuFZG9f4PVppS/AOdw8tLe2fD61JFL//m1YsWQtQ2zErZRtau+Agyk9+BE/bW5nDIXIQVm2qndr3vUETBty+b5eZD9uVPj3K33egy6Fkg/TrA21mwHElf73KEYm2q9nmzFLyoC6OHbEl96hRjsPx2H2V75jpatt7cP85n5Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090346; c=relaxed/simple;
	bh=ZWrAYkEObX8RJzVDe3A4PJku6DRjgp+Pzb2LMv636KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqXY1qrhWFRg4syH09YNfFJwGsFCdQoa3xS9AKKFp5EMR8Xud9f5OQsnwmrlPAcrwXk8ZPFXuQHwgrcY13fZHIgG3OvvfaUs6/vciP2br/o9NHLSg5CmbJd08txJ40Ug2D3TzKUfxKvb1yrtSbUCMKiW2PPEWnrnOmUSjNS1S6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=aMc95SnV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="aMc95SnV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso4732855ad.1
        for <netfs@lists.linux.dev>; Sun, 04 Feb 2024 15:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707090344; x=1707695144; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvV2EpIUxaX7NT7kLqul2ISaFb45XQHzr81IwPkRSMw=;
        b=aMc95SnVSF6WvrAMEA84xUKN5GIJjvnBCvyDPFSvnqLDIZH011HECmZJWEqzSHfs7n
         xLNCHnoiE1+E3PmUyoL9yRk5N/J9eyDPO8CQA9aQWutSP3pyFuXrj/Qc4MFXOLEX/8Jr
         E1Q3fSP8N8nhhdQt6yQmlVBSj/wQfHLIQmGJVGUye0nuki2vaew89z5G/czHLmGG85av
         wT06WJLPj1VOEu5RWLBiiDfAiQPIELXLHuP+tjWnYivzf0VUNFLVs4SQoPbur4N2OzNP
         T0OOt6iHKAK9EezkryK87kcbOqngmUSPFQXQjqxKPFLAz+Agssspuz4jEbftErAMhXoC
         /fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707090344; x=1707695144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvV2EpIUxaX7NT7kLqul2ISaFb45XQHzr81IwPkRSMw=;
        b=h0R26v+y7wnWmMsxRq2OJIB/ko4Ssn7mR8FJfV23RuVHsl11Oz7XhiRX72MiKhtMiq
         8ts83w8wnP1M+9YGPllOOADi5SWO0XZaYmVhJHEGRSwa6R7qpRNRqy6zlR2A6raOKi0i
         WQwQctCO+XGSW/7WjINYyzfvvUGXwdXg9hIE34gHuctrLSge1ZZfyrT2x5nDR2un30AO
         lG4iuuLZkhxmR4ui/kvVXPQ4zbjY6S8vyczcqLGKwfcSSQjIqdMvj6P7ZZI0Cyh5S3Ud
         bfgfe8tPihEkN19DgKMVTxywwED/HEDgAU2C8T0KHMobd/movkUkokiNMAcmZpmq87I6
         IEww==
X-Gm-Message-State: AOJu0Yz/KRNXI9ZHJ4dnb4Tn+N8JDdkWh0yuY4Njbr+LzTbxPE95S0MO
	zv0l1alO//f6nX9cOAXOkeETeyH/F8iQKy7iAG7cpHhF0fX3PvusjKeIHFeGtFM=
X-Google-Smtp-Source: AGHT+IEgPuKAB4wPTf1zcjRLNfL97sIjLpYWWHuGJD3cM/33XdDSLK6OD/xjovQ9r+CU32P944mdSg==
X-Received: by 2002:a17:902:d4c7:b0:1d6:f17b:ecfc with SMTP id o7-20020a170902d4c700b001d6f17becfcmr6355888plg.15.1707090343975;
        Sun, 04 Feb 2024 15:45:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXv058kBTv74LvoPUADWwMn0wYajYRcRQIS/3H9ZLZO04+7JLzQ1H5IKF3thDY/LNJRyBHFuDK9eghvhVB/JQn/O5o0GAkm1izdGtDbIEAeMRcSwV743SoZ9QZFfxmau5rLX+ptSG+6elg8wqlCKClvSnyoCQKhI7E6twx23283M/jFfQwcWNWpOqFGQlI=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902d11200b001d8ee19ab34sm5084689plw.29.2024.02.04.15.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:45:43 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rWmBA-0029Bi-0S;
	Mon, 05 Feb 2024 10:45:40 +1100
Date: Mon, 5 Feb 2024 10:45:40 +1100
From: Dave Chinner <david@fromorbit.com>
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
Message-ID: <ZcAhpOi0UpMhtLYT@dread.disaster.area>
References: <2701740.1706864989@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2701740.1706864989@warthog.procyon.org.uk>

On Fri, Feb 02, 2024 at 09:09:49AM +0000, David Howells wrote:
> Hi,
> 
> The topic came up in a recent discussion about how to deal with large folios
> when it comes to swap as a swap device is normally considered a simple array
> of PAGE_SIZE-sized elements that can be indexed by a single integer.
> 
> With the advent of large folios, however, we might need to change this in
> order to be better able to swap out a compound page efficiently.  Swap
> fragmentation raises its head, as does the need to potentially save multiple
> indices per folio.  Does swap need to grow more filesystem features?

The "file-based swap" infrastructure needs to be converted to use
filesystem direct IO methods. It should not cache the extent list
and do raw direct-to-device IO itself, it should just build an
iov that points to the pages and submit that to the filesystem
DIO read/write path to do the mapping and submission to disk.

If we tell the dio subsystem that it is IOCB_SWAP IO, then we can
do things like ignore unwritten bits in the extent mappings so
we don't have to do transactions to avoid unwritten conversion on
write or do timestamp updates on the inode...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
