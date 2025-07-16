Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174B4315C
	for <netfs@lists.linux.dev>; Wed, 16 Jul 2025 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752627440; cv=none; b=RrW0aFk4ztUt5pTqYeAcraaMJM4xxiaVQYzmIym1l0/wV6Ymlvyngj0TeiqWRvrB43tEW2U63nrEB1V6XJdMZ4Eb94RD+UB9rrtjLQ7dubUp7LNrGVAOZTwo7bAZyNhBegkP4EmDyPI3soh/Z7tpvL3Ex8UjTPQI+MpeOPaUC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752627440; c=relaxed/simple;
	bh=DnkgAXwceu4ogzX9h4y+PJ+cCWlhlR7NXhfTMcsrSIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fS/5V2qZWc+90cY2wnZ1AJKGSV2oJpQfFXhTtUZ1rqTyGdgWvIsJDxrNcwemt21h0CsM2BTmfwvCwtsdsrK8paNaPhv8jdEHVUVeIgslMu0oGyodQZwp1vwu5O2nw5pEY1pHHVEv+oK4M3qp/q6VqKXj2k7l4awucxvh4uWhBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SV9A1kur; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SV9A1kur"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4f379662cso4547392f8f.0
        for <netfs@lists.linux.dev>; Tue, 15 Jul 2025 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752627436; x=1753232236; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KacZvyW/+D5c+CkKTBWmhK+loj5fkAU60jNANOTBA8M=;
        b=SV9A1kurEf+1HbEPvK7yCnzy9kYeN6Tf6junXXivsg5ziamb4WcLXf9kTGSq0o0dbX
         sFzwx8wmjMI/jmIB7gYakDuq26/Kui8uvnOxb936Z84phk2THSYSYVEDsFPtdJRTxZ19
         4kbTPch5lCgcmPgf+9DErayUjrUjn61bPjnRaP36qCLslZfzkJ0uNFYv0FHwLL+GT+Nl
         Yb71WdQXEOJoVVcaA/XftBxDJ5/hPBicfcTFh3XgZdT97WG0f03wamT0nOfjEzAgXhjj
         2wifqWIO6WfqSqxF66RWljWNnadgRc6CzqBMcmpPleMnlhkVhnMN3BjXK5XCEw2PDIgx
         e6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752627436; x=1753232236;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KacZvyW/+D5c+CkKTBWmhK+loj5fkAU60jNANOTBA8M=;
        b=bl+5ZsRZ+BCBhoW+mmzbrFIpFXarKXH8bkEi9j50WkWEEiWcNMxf8hzPjLk5vCNIxH
         DDjbn/4sWOZrF0spEp4osHIRu1Vrw09HrCao5UbwQ8AKh0Xg8XHns9UkFYTOqtHFPZ5J
         pLbdQD/r+b+1/Ho3PNAuRtTqFKWHr7uoZZYF5uXHoz+rA+QdGF+veLAOp+6pLZOQAuz3
         FyHjPnjVJ/Z1/O4q51d/VWKK+wyCwK372cJ7PNZUEEcNQYIktn+41aTkMoeo6NzGNv+h
         2fpbzfvQWKiApWpBJK4iq6n3aaCd6lpkRhKs/wpk84hcOAceIp00Cnp6GkI0SaJWwYmQ
         5TIg==
X-Forwarded-Encrypted: i=1; AJvYcCWCOAeMgs3qSFo2ByRuF/fj6zHaB2qg/ORvR5MHBDdRS+/ef9uGPhRlJ+EhGP+uoWUFkw8l3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyqj4l0cbEDd4vBXi7tagIeDW3EPp8tPnEr58y0jrUo9M6cIhyG
	C+sSmcyUrsH6I4sBdAzo1bDpd/FOAHhmRTECnBQHx2ZcRPOwSiUPXUEeea5Sra09z3c=
X-Gm-Gg: ASbGncvZevEOsa6naxiIWbtTro0BSPpncRXEaXbOdfsJ0BUnBPfDolO5G4x5NQl2Qwo
	qya7syteDRQ83ITR4MAJWP63SM+R123Pc976IqmLfy7FRJaAYcSw7wnt/4bzC3uT0ltOtgWtIUU
	b+4q+eOs+6eto57XaVmdptuLyfGr+xGB9ujkOjmjvapv1KroDlBT+u1LRmYMctus2B9GN0SLGrk
	2+gMQPW3Om4q4Jnz8eurXzTxCJZkpeB6c0DlMwGdPkQ/VJ0AKg2UYCt5ZH1E3tl5nSfyTMghJXt
	15NFynPEyjla79Z/ZwMBoqVIeXR0BVqQpAqzmXJ7IZlaBZgfHU7ndJXF2z8QEtRY3PS4fwNv5Uk
	0I4EPdhAw6psN42+4lQ6CVUWmx15PFsSeElVlLlcl1Q4ivSC1iw==
X-Google-Smtp-Source: AGHT+IGmM0n20dxhtQ6vMPJL8jS+hYaNOO5Rpe4CXLe7RvspyCFw9ZMsMSHoEA6/McxI5CdSoNbUKg==
X-Received: by 2002:a05:6000:3ce:b0:3b6:d6d:dd2 with SMTP id ffacd0b85a97d-3b60e4cb532mr348001f8f.25.1752627436011;
        Tue, 15 Jul 2025 17:57:16 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4332cdcsm114942995ad.145.2025.07.15.17.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 17:57:15 -0700 (PDT)
Message-ID: <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
Date: Wed, 16 Jul 2025 10:27:05 +0930
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <aHa8ylTh0DGEQklt@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/16 06:10, Matthew Wilcox 写道:
> I've started looking at how the page cache can help filesystems handle
> compressed data better.  Feedback would be appreciated!  I'll probably
> say a few things which are obvious to anyone who knows how compressed
> files work, but I'm trying to be explicit about my assumptions.
> 
> First, I believe that all filesystems work by compressing fixed-size
> plaintext into variable-sized compressed blocks.  This would be a good
> point to stop reading and tell me about counterexamples.

I don't think it's the case for btrfs, unless your "fixed-size" means 
block size, and in that case, a single block won't be compressed at all...

In btrfs, we support compressing the plaintext from 2 blocks to 128KiB 
(the 128KiB limit is an artificial one).

> 
>  From what I've been reading in all your filesystems is that you want to
> allocate extra pages in the page cache in order to store the excess data
> retrieved along with the page that you're actually trying to read.  That's
> because compressing in larger chunks leads to better compression.

We don't. We just grab dirty pages up to 128KiB, and we can handle 
smaller ranges, as small as two blocks.

> 
> There's some discrepancy between filesystems whether you need scratch
> space for decompression.  Some filesystems read the compressed data into
> the pagecache and decompress in-place, while other filesystems read the
> compressed data into scratch pages and decompress into the page cache.

Btrfs goes the scratch pages way. Decompression in-place looks a little 
tricky to me. E.g. what if there is only one compressed page, and it 
decompressed to 4 pages.

Won't the plaintext over-write the compressed data halfway?

> 
> There also seems to be some discrepancy between filesystems whether the
> decompression involves vmap() of all the memory allocated or whether the
> decompression routines can handle doing kmap_local() on individual pages.

Btrfs is the later case.

All the decompression/compression routines all support swapping 
input/output buffer when one of them is full.
So kmap_local() is completely feasible.

Thanks,
Qu

> 
> So, my proposal is that filesystems tell the page cache that their minimum
> folio size is the compression block size.  That seems to be around 64k,
> so not an unreasonable minimum allocation size.  That removes all the
> extra code in filesystems to allocate extra memory in the page cache.
> It means we don't attempt to track dirtiness at a sub-folio granularity
> (there's no point, we have to write back the entire compressed bock
> at once).  We also get a single virtually contiguous block ... if you're
> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
> vmap_file() which would give us a virtually contiguous chunk of memory
> (and could be trivially turned into a noop for the case of trying to
> vmap a single large folio).
> 
> 

