Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054E57EDA6
	for <netfs@lists.linux.dev>; Wed,  9 Sep 2026 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970323; cv=none; b=LtC7+YxZ+9CC/JUsn773VBNZHkTQK/1U1YiJiFTBCvfJucsOqmdpuswS0gI8/BdMi824bvjnMTRkml3ZzhMWuxxjVop60PP3iatqBenYo+BVS5dsL0EAjVgsCsS+ksqjGpnH0TR60AqD0J6Hs+EEvogZnI+CaATbhEnz2d7OHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970323; c=relaxed/simple;
	bh=hiRBQugCjUC2qSlftimk1/dBleMnW9pQ7uDf9NI+8s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pfk6LykKnWrEMPngrIfdGvkfjshAQ70wIfZbJ5SrA+PldYF/XY014dy9a6+ERlRqB1KZxZMv4rj50ggW9lX9TO5FsQTYcdWHebAkozMDTMkDQY0otsUnddAptw1aD0ELgfQY290/uNqcNiavAIoA+m8i2HoGL/HWMDs7iwqBVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bt4ArTgB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt4ArTgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788970320;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJ6zoCiMWbIIPldwdYsAIIdGbzVoK/NeTnUzI9OwSjE=;
	b=bt4ArTgByqIlGNiJKqvgSGgGeGjYdqoZVPpftU4vQo9jz/rtvcaVYoho2fK8n+BlAjiBaR
	Xm4aywFgQXyxxI3OuNdRFoVOmkzBSa7vKiKvMBNm7eZeBf9Xdw1Nhnj5Y6eCfJisCBCyZe
	3PMabTZ8ESdRh1KL/RohuIpwEw5wfFg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-LSuuVxwwOxq8POdd3iMusw-1; Wed, 09 Sep 2026 12:11:59 -0400
X-MC-Unique: LSuuVxwwOxq8POdd3iMusw-1
X-Mimecast-MFC-AGG-ID: LSuuVxwwOxq8POdd3iMusw_1788970319
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-836caf085e0so87517077b3.1
        for <netfs@lists.linux.dev>; Wed, 09 Sep 2026 09:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970319; x=1789575119;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AJ6zoCiMWbIIPldwdYsAIIdGbzVoK/NeTnUzI9OwSjE=;
        b=d0d2dJxLX5A3N+zGBib3MCppvvT5SMbIxGsq5a5O3mqHFDk1AP/KYOSFRj1faKOBym
         Yf8uApVpdbjWgs/8kgShyC4uzty/GEYTFPZl+CDHSrMRRrAiCBKvnAaLNaO+UY3C0hcv
         HdIyxGzQaIJ+g54cvPbOloTDRLHD79jA+9TSAafXvLHGe5OoQg+D3olqlOmmVPoSRDwE
         RFKLG8ST9hnC0nm1xgbaqkldtCxRuDWhbn/iGBCFvf1RyP3XElCAAq7ltF9QwDvabFOR
         Lc9Ka+R+j9E24RXpnoZDserO9yY5jyHkAJb8eerCfe0xCg7ELnXg6BKkaONcC3W4kJgA
         2nqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwv7Sxe5IdMkeVaJ/78fkBuxQ1N/9UWaEYD/55v0d4g8YU6oSGRetaTJ0GMehiiRBjQoPDveg==@lists.linux.dev
X-Gm-Message-State: AFuF++mNm1KQsqWOuNL2Faz2bTal1mjQLg7HZ8sQ8wf0dBUXvV0ypqni
	v5uv+djvkWln79yTpw8W0iAWsPoOIkt+TllFrVmTVLshHENY2fbvmFS52iVaZI087dOFt0hMbLK
	5prvOlyoT6Et/mQMzTQRauNRYeTPf9N/864uW1RLyvHUKVgueQ8i6eBHaQt9nJC56
X-Gm-Gg: AYBFou2wnoQSpWDIvNVFM7d+YIGu1DEXfTUX2i9RI836F9S1OZzP0A0/vVUJ6EUaS8/
	3bVfggB/3BcsqfqnxZFuCFLDgkAJXhpFjVCXzypcijsfrHPwZFm0DcF+1uIjxUfemnbgeIo3h1K
	9u5fBG9qLYOt05zg2wwaqtaezhg66MbWSk+RgpKSqazgxRA4CDIS689lM96OJZ/l+ifWCKKdY0J
	62tWAeftQZGMUrYtZcmKcM6oatAcQI6J1ZAe9L3jKJ+0cEagWrBerwBxIIG99po24qTXEhYAAii
	n74JOsjuPQmhFpRGMlAHVPDINkPYHKHpBo0mNXXtcZ7oB8EErQfHp1vq/a5Ox4A6AIJeznr9K9F
	YvCq5Kew7TeDTFgdhamf6IThNF99cVvLHhwa5eT7i
X-Received: by 2002:a05:690e:bc4:b0:664:c3aa:66f0 with SMTP id 956f58d0204a3-6710371652emr2217070d50.39.1788970318493;
        Wed, 09 Sep 2026 09:11:58 -0700 (PDT)
X-Received: by 2002:a05:690e:bc4:b0:664:c3aa:66f0 with SMTP id 956f58d0204a3-6710371652emr2217055d50.39.1788970318005;
        Wed, 09 Sep 2026 09:11:58 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8b8fsm12713671d50.2.2026.09.09.09.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 09:11:57 -0700 (PDT)
Message-ID: <afd68097-b2b2-47e5-889b-fb077e7a9247@redhat.com>
Date: Wed, 9 Sep 2026 11:11:56 -0500
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
References: <a385053c-1c4a-4060-a3bb-befa007ddb33@redhat.com>
 <1714046.1788952509@warthog.procyon.org.uk>
From: Frank Sorenson <sorenson@redhat.com>
In-Reply-To: <1714046.1788952509@warthog.procyon.org.uk>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xnbQvmONQRpMp6cC0G3bNJl5lq-svL_lzAE7VVCgxK0_1788970319
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/9/26 6:15 AM, David Howells wrote:
> Hi Frank,
>
> Can you try this?  It can be triggered manually with something like:
>
>     xfs_io -c "w 100 100" -c "r 0 4096" /xfstest.test/foo

Hi David,

With the patch, generic/759 now runs to successful completion on cifs mounted
with 'sign'.

Two things, though:

1) IIUC, folio_alloc() returns an unlocked folio holding a single reference, so:

         if (sink_to >= 0)
                 for (; sink_from <= sink_to; sink_from++)
                         folio_unlock(bvec_folio(&bvec[sink_from]));

unlocks something that was never locked, and never drops the reference.

So should these be folio_put() instead?

With CONFIG_DEBUG_VM=y, I think that's a
VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio) on the first gap
read with a non-empty dirty region.  My test VM has it off, which is
why I got a clean pass; but with bpftrace, I see 190 leaked order-0
sink folios (760 KiB) over one generic/759 run.

2) if netfs_alloc_request() fails, the kfree(bvec) at alloc_error is reachable
before bvec is assigned, so I think we need to initialize it to NULL at
declaration.  (It uses mempool->alloc() directly for the read origins rather than
mempool_alloc(), so it can genuinely return -ENOMEM.):

        struct bio_vec *bvec = NULL;



With s/folio_unlock/folio_put/ and initializing bvec to NULL:

Tested-by: Frank Sorenson <sorenson@redhat.com>

(but I'll retest without those additions if I'm mistaken... it's happened before)

(as an aside, 'git log -S' on the bvec_set_folio(..., sink, ...) line puts
the aliasing earlier than the read rewrite -- should the Fixes: be
7f84a7b9892d ("netfs: Make netfs_read_folio() handle streaming-write
pages") instead?

Frank

-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

