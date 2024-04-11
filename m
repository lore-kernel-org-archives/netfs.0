Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F07156CF
	for <netfs@lists.linux.dev>; Thu, 11 Apr 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849141; cv=none; b=LrW2j1uTRTIGWBxajNAXsZ5ArDARi+NCtGAoULHajWlpQSGrlg9rI2n8quJr+qZHNWwFdVqHGkL3A18zmxBQ636Ka6xeHzQ4Lu8IMtHk933goOclsro5HK0/jDHaMFg6aQh1q1w2Eehpl3vRrF0JlqW7sGYE2Qut2jM0ltp0aT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849141; c=relaxed/simple;
	bh=S0tSkli8JleHY8iE9O2afY6bV3mjLC/eVHPCMEho8Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4MGeXB5ZJu8SyaVG4mmzetcyoZo97xSFgBibT3pDVz0L7Vbp7CmN46IX8Ui2ZF/OKF+aB7tRpXSFeI0vp3vyjmi7HJyo2KTcIt8VfJielRLZd5Tkchu67ESbwew7qOY+SL8YLagS0zC8dtPj5epNtCThYFAvNKHguX6nxjHdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=inpiZiA5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="inpiZiA5"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e2b3e114fso8555540a12.2
        for <netfs@lists.linux.dev>; Thu, 11 Apr 2024 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712849138; x=1713453938; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CABfqMACNUngHNLxS+WM0hHJ1yaxWLelGbJxYjHioD0=;
        b=inpiZiA5Gyi4RaIN784iOLjh6claf3cmTSXTpRQ6/mnNpJWL62aqH7XFbQascmZzbn
         Zcd3K7a2yoXE/4g5F+UDEg0pOaLpnj8EJiy2SMBrrzFR5iC2CfXGUJjDwGrTIyzAhyPt
         yEzidNU+xWyYo3gLp7p6SIHgOj8ULWFjzZlTiExTKvXAy09Z4P2HBsTbMv1h/WiAypos
         GOZmneAsg90EzQfPNHroGENFd/RkNPBe0NjsDgGeeXOfJxrKXqtxjS9/os5bca7hr5JD
         AXYHM2f3VLrK8lUMED82a5TXgWOvvNlajA2oJBREL944thb5rKHPCbgVOW0PK3QW2lrN
         sHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849138; x=1713453938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CABfqMACNUngHNLxS+WM0hHJ1yaxWLelGbJxYjHioD0=;
        b=E8mw1KvASyZLT0AbeafOM62x62W5iS4w5B0jQD4VF6Da+HpYnG4b/jXOL9zwIyg8Vd
         wHX4W6OykULbmuBI8ycCArJghnQ5vM+dwEFjsJ8mg0HWlridJum1SrR9RJ9Yk13HBQEd
         CmSE9goDACtRQBm84GJZJfmvdm5IRB/nmMuF87xuv703YCe9XRMIerOfZ4+CqjXi9IxX
         WpfPculC2wtIgyJ8jI1zOWgrQ/N9UeGiaiaKJs2/H2ED86d33brGitwpQRbPIXXpMRdD
         xknJeuw3QJSc3ymCaQYQaqIwzGoxeADkqWxn/5aZvkMGDHpnLFLAFWHbcwjZi7P0U0Ch
         rcJw==
X-Forwarded-Encrypted: i=1; AJvYcCXnB37l5fUwOue2i4tKMUYwVQtQ39ya1BinZK/aWqUOMO8HBzGFsu7Sld1/MsNmCTQY6FbI3AlWgcLL7T3CGnn2Zb56mO4=
X-Gm-Message-State: AOJu0YwiHoD5grYq+9mOb+yMYm++n6a+ZAvErze9LfND6F8X9JXf7kIn
	b5lGSjq1ae/bGc3V/Jpbb2Ka5pzjyshTsy70+GRe9h3uphfyktn8yHDa5P69b70=
X-Google-Smtp-Source: AGHT+IEEewk7llSPmgrxe/7mA2rySV/OUDonUpYE2d0l2M0z39pI2HKiyjdOd8AbAw/PCbmxmW//Bg==
X-Received: by 2002:a17:906:4f06:b0:a52:3d1:6769 with SMTP id t6-20020a1709064f0600b00a5203d16769mr44591eju.14.1712849137563;
        Thu, 11 Apr 2024 08:25:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r3-20020a170906350300b00a522c69f28asm225076eja.216.2024.04.11.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:25:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 18:25:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	speakup@linux-speakup.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-afs@lists.infradead.org, ecryptfs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-arch@vger.kernel.org,
	io-uring@vger.kernel.org, cocci@inria.fr,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] treewide: Fix common grammar mistake "the the"
Message-ID: <0bd7ccc2-4d8c-455b-a6c2-972ebe1fcb08@moroto.mountain>
References: <20240411150437.496153-4-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411150437.496153-4-thorsten.blum@toblux.com>

On Thu, Apr 11, 2024 at 05:04:40PM +0200, Thorsten Blum wrote:
> Use `find . -type f -exec sed -i 's/\<the the\>/the/g' {} +` to find all
> occurrences of "the the" and replace them with a single "the".
> 
> Changes only comments and documentation - no code changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---

It's tricky to know which tree a patch like this would go through.  We
used to have a trivial tree for this stuff but I guess that didn't work.
It's possible that it could go through linux-doc, but probably it has to
go as a set of patches through each of the trees in the CC list.

regards,
dan carpenter

