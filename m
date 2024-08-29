Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5971946C4
	for <netfs@lists.linux.dev>; Thu, 29 Aug 2024 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934591; cv=none; b=nDfilNUjfptlcnsOTjo40cq32J/BvyBGHWSFyRxh4vBJVPlvqR03xcD8w0IkjDUGCy+9njCr16vwio697Mc6uGx0beG/fKESuqQPhwQhuIG89geGTLe+g776vqzIAhKDX98wwvHpKCPmbXa3qKjX1KwfbtWykNlxzeLhrlqmG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934591; c=relaxed/simple;
	bh=FGHM4XNfa/cVlTtzzUXPSLt9FVuJ0sM45yJhXV9JDCI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XwS16WTNkX3xMcb+Oe//BIveCE6t62O9I6ZNjLgT7TlFaCH1z88kvaYY/c480g6j9wKOhXGU6cmUuCJzBLKhB7/uxDsm+Op7U8xonci04UlY4bmUk3gn03qtO5/gBAJzqsYPaBojDG6upfuNYgQWHtYgrc1TyidH/ACPxQWzErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ESz+XOLr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ESz+XOLr"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a866966ffceso3143266b.2
        for <netfs@lists.linux.dev>; Thu, 29 Aug 2024 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724934586; x=1725539386; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yi9q0gAo3pbGHakMMQ1qlw9QBFV5RKXeNwADykw9ibU=;
        b=ESz+XOLrueI6aAFrf/uRtnPqTQF7G3NEK2mhjqF2qqJK9EsqWq1Oxj1GYD+4+F1IWo
         kYW92U9ZOSverN5q8gWVozaOmiOPBCxtsZVYpZdN+pIHdcVeatjP9bl7acGGpmoKjsh7
         u+WJiiR2VaS3CL2ueNFzY3rMY9rQ0o/mb2cckedWv0aJBj1vkIMy7NQjkqxn5dvI8hB/
         veY6R+0W9Fb9Tb/XpO6dXAuzq5CPD1xbt4YmOxVVwSpE2vwo8V3PKTu2zpyrBGG74CDX
         eqYqiYwTl+faHrUolFFDBKhGkc+Qn7/4qj3dFBib4UEM0q2DMKHp+jFUzX8kYVx7TNhI
         7egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934586; x=1725539386;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yi9q0gAo3pbGHakMMQ1qlw9QBFV5RKXeNwADykw9ibU=;
        b=pK3gkQ2IeKKSNQUqbHUynWOgoS109v39ywpODVovP5yf+ql4DIxMd/nRKGcshJuLJf
         LpVAcKy28lMwFSti8RS1kYEp1K1if9zC0u/2ilwJ/4nZjc1eaiihn8wf7s9chcWJV70R
         +2bWkKl+yQwOuzmKVobnVT+pC2aMyYMtpF5qsrPpbj52eNLpyc4YhJU2FJlfOu1xluLC
         zneno73CvJcmqnswacvVVAcBHDKHBzF+ieUSx5gDI6SgefZ1eTbldRfPBJ9DuFWbWdIf
         5TRe51EhqbZpIbHiLP1kL3lLtT26dPhcX5/aa1e7EikLYKxxGyqln796b7YxBx+kAax2
         +Fhw==
X-Gm-Message-State: AOJu0YxAIub3P7UCIsR+gtF+an2fvXNiONTYP65NQ+L0G+i7C7ggpPdU
	WaMQwlPec10tn8B4Bgb6chW4IfOLv58nzEVRgUhx+QERHdbHf4yNNT0KvWXIRqve3JgZ+HULnnC
	7k0w=
X-Google-Smtp-Source: AGHT+IGC9nmjU8Jg5RFOgij0MQ/hzj3G8U3KttB3SuxCDoCApdLe6XuQc8iokX8LRBfJC/kKOpynpQ==
X-Received: by 2002:a17:907:3d88:b0:a80:79ff:6aa9 with SMTP id a640c23a62f3a-a897fb15d30mr118842766b.8.1724934586358;
        Thu, 29 Aug 2024 05:29:46 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:2965:1b4:50ce:19ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb0f0sm73372866b.20.2024.08.29.05.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:29:45 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RESEND PATCH] fscache: Remove duplicate included header
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240628-dingfest-gemessen-756a29e9af0b@brauner>
Date: Thu, 29 Aug 2024 14:29:34 +0200
Cc: netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>,
 dhowells@redhat.com,
 jlayton@kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4A2EAFA2-842F-46EF-995E-7843937E8CD5@toblux.com>
References: <20240628062329.321162-2-thorsten.blum@toblux.com>
 <20240628-dingfest-gemessen-756a29e9af0b@brauner>
To: Christian Brauner <brauner@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)

On 28. Jun 2024, at 10:44, Christian Brauner <brauner@kernel.org> wrote:
> On Fri, 28 Jun 2024 08:23:30 +0200, Thorsten Blum wrote:
>> Remove duplicate included header file linux/uio.h
>> 
>> 
> 
> Applied to the vfs.netfs branch of the vfs/vfs.git tree.
> Patches in the vfs.netfs branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.netfs
> 
> [1/1] fscache: Remove duplicate included header
>      https://git.kernel.org/vfs/vfs/c/5094b901bedc

Hi Christian,

I just noticed that this patch never made it into linux-next and I 
can't find it in the vfs.netfs branch either. Any ideas?

Thanks,
Thorsten
