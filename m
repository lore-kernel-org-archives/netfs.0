Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B97B5908B6
	for <netfs@lists.linux.dev>; Wed,  9 Sep 2026 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988122; cv=none; b=CihhZDT76o7fqXS7B2DbNBnZjxmhMA5cjENtM+W5hxyrp/28kLSBT9AFZSlD1R95xcnBpcccoQrKNs0mVTcORcq/74/iw4hncaFLdKbbI9083mEGk8DANNI+SfaEBUKrmrkZBPlnLE1filYhgc9ZMDCPq1cUMWPxHsGnRumVdfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988122; c=relaxed/simple;
	bh=v6XN1bSzrdiOZsy+gxDBorIxvgzRZF1Y/gKavtMSJdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VthHx39mOxJDv6334LJ67qgocTqD7ah7UvD9s/rhH5LNMaRyRV3R0ysmvlacZLtKv5ac1L3HExJdjpG5/tyvLEEkhgmXEgZrHlIyGWLgYmpw69QivPxaNE9OfTyb343AkLf2BNguRqe41oBECUcpsUU2Hl3JkS3TkiUhTwhipog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EieMnnqe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EieMnnqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788988120;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeCu1I7ci4XqifONO9NCiEC08kQGS9StekRATuRZUpY=;
	b=EieMnnqe0E7eM+N8lsZQs2oEeaVwOpRO9hX2Ny8NHzmbCzz/S/DjpcvmaUvV2my4FH5len
	IyeFqpnVaLukUZsQnmxVh4x+qt/vM5F8DKvNniIPYqA0fWE4BCe+e7WyxKu69qTpPkhvKB
	dhKUlGxiBY3SrgvSoib4WKLilvqj00A=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-CidJbi70PUGyWVXT2CinOA-1; Wed, 09 Sep 2026 17:08:38 -0400
X-MC-Unique: CidJbi70PUGyWVXT2CinOA-1
X-Mimecast-MFC-AGG-ID: CidJbi70PUGyWVXT2CinOA_1788988118
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ef04756caso127448111cf.1
        for <netfs@lists.linux.dev>; Wed, 09 Sep 2026 14:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988118; x=1789592918;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JeCu1I7ci4XqifONO9NCiEC08kQGS9StekRATuRZUpY=;
        b=GFqGjrtilJVxhtK+B00vZW28pU5m7nsPoWptutagqMCflTmgOBGrDtT0bvzm2Q25jt
         m2UaoHEVqUFH+lIf7z/82sBdFg0YFz41umM0x1l+wjwIwezPdRHOsQ44S71QU+D3K0UK
         N9JhzPfk5wUvWIXtwljSAj3iNqWxo1IypUHVcr+DmCokfODWFUVSiCKxJ7qpDIRQlIyn
         WX8QZcfuqDYTARf1LCNkBUeywx2/Yj1W71F+dGTVc4HuG9qba24ARDpUTiiNlBBVC8BS
         X695GAO0wRuUElJFiLJZ9lEkaz8ffAJf52TXk3CdNhlRHYgaM76NzT0eY1lQfx8NQdsD
         jpRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhs0myKTmWIlmWmJ74nYygcfeHp4So+9z6MGXw4bv2mviyNCdWSubZyzFM1F5qsWj1lWOJXw==@lists.linux.dev
X-Gm-Message-State: AFuF++n2Ew644nMJu0pEIUon7UbTL9vGbC88z0Ph+pLNfCDURF9czmpJ
	V+6IOuOfXwHXjtyrvNqesASroQOvGXLjxOB3/jP5CFNZU2IXiTEetl5Z7Sm+qSUlHCuvMePszN9
	jy4sHUYAKTdNE6+TGgEpgpwpzb79jaRW+uEU4Gzc/ezgVVDpB/mWPn0BV
X-Gm-Gg: AYBFou1Fbmb5ZbhIkOi7tbE0oRs86pVGCaAsPRrUnkCfYD0eHPeAGLuk+3GYGZ/96Cr
	+qyo2ZWKQrEdvDCdluafLTn4SBhIKkEYCBxRmENXGgzX10FMvwbN98aV4Ucc9BoWjJx+RIReu1i
	O9zf07x2wA3YlRsGBlAgfBUiJ6SMqlFx1+7CRunUfXvKPoW1PcX5MzoPd7w1y80Bvq5x3BdFqsz
	Jg0hygTgDiJrILNk9EwdhL5M+PuVRedQXXT+Wqv2Ge3Qe2wa7JJeXUwvSWYrLg5ufpFZJ6jtTp3
	Es2itPff9weHIT8dROSnP1IvLCEmGy3OIMGTdySdtdaNCf2MSf2hLxRwxN5bJ+njIaFxep0NXVk
	TqMD4iY2gWLBUi8b4o87fo4I6XZnfd7ddpuvuTI4+
X-Received: by 2002:ac8:5cc1:0:b0:530:b2e2:2f1 with SMTP id d75a77b69052e-530b2e23739mr27765661cf.51.1788988117907;
        Wed, 09 Sep 2026 14:08:37 -0700 (PDT)
X-Received: by 2002:ac8:5cc1:0:b0:530:b2e2:2f1 with SMTP id d75a77b69052e-530b2e23739mr27764751cf.51.1788988117237;
        Wed, 09 Sep 2026 14:08:37 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9104049d30asm153786676d6.0.2026.09.09.14.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 14:08:36 -0700 (PDT)
Message-ID: <317dd59c-819f-4bbe-a196-3946c30eb0a3@redhat.com>
Date: Wed, 9 Sep 2026 16:08:34 -0500
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: netfs_read_gaps(): aliased sink folio makes the read destination
 unreadable, SIGBUS on cifs with signing
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Jeff Layton <jlayton@kernel.org>,
 linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
 CIFS <linux-cifs@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <afd68097-b2b2-47e5-889b-fb077e7a9247@redhat.com>
 <a385053c-1c4a-4060-a3bb-befa007ddb33@redhat.com>
 <1714046.1788952509@warthog.procyon.org.uk>
 <1730052.1788974127@warthog.procyon.org.uk>
From: Frank Sorenson <sorenson@redhat.com>
In-Reply-To: <1730052.1788974127@warthog.procyon.org.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J2MZk0isExIxhqYclsbMvrOTJ-NqlcGfWwnbO3FJZGI_1788988118
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 12:15 PM, David Howells wrote:
> Try #3...
>
> David

retested successfully with v3


Frank

> ---
> commit 05abad6ef207137fd3a2559d6ac242d1f94c60aa
> Author: David Howells <dhowells@redhat.com>
> Date:   Wed Sep 9 11:36:30 2026 +0100
>
>      netfs: Fix netfs_read_gaps() to use separate sink folios
>      
>      Fix netfs_read_gaps() to use separate folios rather than re-using a single
>      sink folio to discard the unwanted data so that cifs checksum checking sees
>      all the data that was fetched.
>      
>      Fixes: 7f84a7b9892d ("netfs: Make netfs_read_folio() handle streaming-write pages")
>      Reported-by: Frank Sorenson <sorenson@redhat.com>
>      Closes: https://lore.kernel.org/r/a385053c-1c4a-4060-a3bb-befa007ddb33@redhat.com/
>      Signed-off-by: David Howells <dhowells@redhat.com>
>      Tested-by: Frank Sorenson <sorenson@redhat.com>
>      cc: Paulo Alcantara <pc@manguebit.org>
>      cc: Namjae Jeon <linkinjeon@kernel.org>
>      cc: netfs@lists.linux.dev
>      cc: linux-cifs@vger.kernel.org
>      cc: linux-fsdevel@vger.kernel.org
>
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 424df70a5c30..105194de6e13 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -482,15 +482,14 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
>   	struct netfs_group *group = netfs_folio_group(folio);
>   	struct netfs_folio *finfo = netfs_folio_info(folio);
>   	struct netfs_inode *ctx = netfs_inode(mapping->host);
> -	struct folio *sink = NULL;
> -	struct bio_vec *bvec;
> +	struct bio_vec *bvec = NULL;
>   	unsigned int from = finfo->dirty_offset;
>   	unsigned int to = from + finfo->dirty_len;
> -	unsigned int off = 0, i = 0;
> +	unsigned int off = 0;
>   	size_t flen = folio_size(folio);
>   	size_t nr_bvec = flen / PAGE_SIZE + 2;
>   	size_t part;
> -	int ret;
> +	int ret, i = 0, sink_from = -1, sink_to = -1;
>   
>   	_enter("%lx", folio->index);
>   
> @@ -515,24 +514,23 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
>   	if (!bvec)
>   		goto discard;
>   
> -	sink = folio_alloc(GFP_KERNEL, 0);
> -	if (!sink) {
> -		kfree(bvec);
> -		goto discard;
> -	}
> -
>   	trace_netfs_folio(folio, netfs_folio_trace_read_gaps);
>   
> -	rreq->direct_bv = bvec;
> -	rreq->direct_bv_count = nr_bvec;
>   	if (from > 0) {
>   		bvec_set_folio(&bvec[i++], folio, from, 0);
>   		off = from;
>   	}
> +	sink_from = i;
>   	while (off < to) {
> +		struct folio *sink = folio_alloc(GFP_KERNEL, 0);
> +
> +		if (!sink)
> +			goto discard;
>   		part = min_t(size_t, to - off, PAGE_SIZE);
> -		bvec_set_folio(&bvec[i++], sink, part, 0);
> +		bvec_set_folio(&bvec[i], sink, part, 0);
>   		off += part;
> +		sink_to = i;
> +		i++;
>   	}
>   	if (to < flen)
>   		bvec_set_folio(&bvec[i++], folio, flen - to, to);
> @@ -553,8 +551,10 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
>   		folio_mark_uptodate(folio);
>   	}
>   
> -	if (sink)
> -		folio_put(sink);
> +	if (sink_to >= 0)
> +		for (; sink_from <= sink_to; sink_from++)
> +			folio_put(bvec_folio(&bvec[sink_from]));
> +	kfree(bvec);
>   	folio_unlock(folio);
>   	netfs_put_request(rreq, netfs_rreq_trace_put_return);
>   	return ret < 0 ? ret : 0;
> @@ -563,6 +563,10 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
>   	netfs_put_failed_request(rreq);
>   alloc_error:
>   	folio_unlock(folio);
> +	if (sink_to >= 0)
> +		for (; sink_from <= sink_to; sink_from++)
> +			folio_put(bvec_folio(&bvec[sink_from]));
> +	kfree(bvec);
>   	return ret;
>   }
>   

-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

