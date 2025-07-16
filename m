Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A20B139D0A;
	Wed, 16 Jul 2025 01:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752628584; cv=none; b=nsKwFXMf1injop5TueBgn6riYgXM1kcCFT4argQLyPwFnSo7ZcXwMIRO02ljWmi5poVCAujQXJfbcS1RxjcQVDKmVuW6ADQVeKVaq5RPUbwM0B9m81NVzVJqDHoxbY3LGwtH+1oCYICZaNmgDIfdKfRLm0qNoe+w2RVm21GdB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752628584; c=relaxed/simple;
	bh=77AnnyuZa1o+SszL3U2bIAmQVwUlngsW+1sVL6AGjRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WgIYZrEgbUheNaw7hfODL73yoWQ+RAV6CTiiSSw8II2QMmHjuY7bto+mCmIV62lAy39/ggX4lJn8x0+RefyFdYdkFsG+Lb/xV6+3WDGH16jX1vAFbHRXv2h1lGuaSzNDqIxqp/cuMgWqUsFZPvF1G9pm7sMg7ns1dzZuvp6OXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qS4/mHlw; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qS4/mHlw"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752628578; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kNCZo6e03bIhaM3yJ6Z7GsBUCWM2xE3LHwyTmkn0gfM=;
	b=qS4/mHlwIqEA0JMGrsn+FxIKH2bTQHBxfJIh+GUsuSFKiNDLBWVcAhGVpGGemAqXuVoEJDjAaoWouNhPr8g7J4iFgja2HRlWQDkiPSJyo58AUjNX8U6FuKy430h5LFJKy7/bkYGgn9OXo+0jhuA4dTYI0v8CIUKs9yKRms5uL6Q=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj1sJXu_1752628575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 09:16:17 +0800
Message-ID: <eeee0704-9e76-4152-bb8e-b5a0e096ec18@linux.alibaba.com>
Date: Wed, 16 Jul 2025 09:16:14 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Qu Wenruo <wqu@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, David Howells <dhowells@redhat.com>,
 netfs@lists.linux.dev, Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

...

> 
>>
>> There's some discrepancy between filesystems whether you need scratch
>> space for decompression.  Some filesystems read the compressed data into
>> the pagecache and decompress in-place, while other filesystems read the
>> compressed data into scratch pages and decompress into the page cache.
> 
> Btrfs goes the scratch pages way. Decompression in-place looks a little tricky to me. E.g. what if there is only one compressed page, and it decompressed to 4 pages.

Decompression in-place mainly optimizes full decompression (so that CPU
cache line won't be polluted by temporary buffers either), in fact,
EROFS supports the hybird way.

> 
> Won't the plaintext over-write the compressed data halfway?

Personally I'm very familiar with LZ4, LZMA, and DEFLATE
algorithm internals, and I also have experience to build LZMA,
DEFLATE compressors.

It's totally workable for LZ4, in short it will read the compressed
data at the end of the decompressed buffers, and the proper margin
can make this almost always succeed.  In practice, many Android
devices already use EROFS for almost 7 years and it works very well
to reduce extra memory overhead and help overall runtime performance.

In short, I don't think EROFS will change since it's already
optimal and gaining more and more users.

> 
>>
>> There also seems to be some discrepancy between filesystems whether the
>> decompression involves vmap() of all the memory allocated or whether the
>> decompression routines can handle doing kmap_local() on individual pages.
> 
> Btrfs is the later case.
> 
> All the decompression/compression routines all support swapping input/output buffer when one of them is full.
> So kmap_local() is completely feasible.

I think one of the btrfs supported algorithm LZO is not, because the
fastest LZ77-family algorithms like LZ4, LZO just operates on virtual
consecutive buffers and treat the decompressed buffer as LZ77 sliding
window.

So that either you need to allocate another temporary consecutive
buffer (I believe that is what btrfs does) or use vmap() approach,
EROFS is interested in the vmap() one.

Thanks,
Gao Xiang

> 
> Thanks,
> Qu
> 
>>
>> So, my proposal is that filesystems tell the page cache that their minimum
>> folio size is the compression block size.  That seems to be around 64k,
>> so not an unreasonable minimum allocation size.  That removes all the
>> extra code in filesystems to allocate extra memory in the page cache.
>> It means we don't attempt to track dirtiness at a sub-folio granularity
>> (there's no point, we have to write back the entire compressed bock
>> at once).  We also get a single virtually contiguous block ... if you're
>> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
>> vmap_file() which would give us a virtually contiguous chunk of memory
>> (and could be trivially turned into a noop for the case of trying to
>> vmap a single large folio).
>>
>>

