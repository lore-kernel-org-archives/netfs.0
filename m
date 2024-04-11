Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22C4653A
	for <netfs@lists.linux.dev>; Thu, 11 Apr 2024 22:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875207; cv=none; b=EdGMRWWDEnX/w5bs9F7RhRX6iEb+oqU3lwg0fGR8HXlRZLhDhPABjU9VO02d1F//nqtODD5AoJtWwMRK+3zj/d4lgmn76LT5HKpdw4T8kz/5nrggWAS2Aaf532PTtNbLuNrNeki5nKsF5zpdFqqDK2N0CYMpg3JgrdpbEFwQvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875207; c=relaxed/simple;
	bh=S4TnsFcjuXgA9nuQRAvIeS3/zSNBm8/9BgUmS0MLmqs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ukHZ8uZ8jpCauihr3lylKFKnrHi6TpSB0KnoNIbr+dnBu7pc5TyLeUU8c3W3e0/M/Xen8v6Lk3Kqwa/9buJJg5OpGW0I07TcGlafR1BXS2mqF8TtSqDEBWLqpW2wYgzt2i9cHtf8N1UxR6nYRrF34oQnig0E91eBefd3K6EvY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=3FvyYYzJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="3FvyYYzJ"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d6e23253so393870e87.1
        for <netfs@lists.linux.dev>; Thu, 11 Apr 2024 15:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712875203; x=1713480003; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4TnsFcjuXgA9nuQRAvIeS3/zSNBm8/9BgUmS0MLmqs=;
        b=3FvyYYzJ0BZGLU+oi0cizDRpOHUYfLK2UbRGJ5ou9ueSB2Uynl5tpg10GjrZumTZCq
         VKUscsxcQdeFY+pykcp/w3kjiB3/mtYob9PNzI9Fd+1dza3gLpOs6yxCO+GosypMCLvF
         MBcyvDmU2is5MnXC9jS9YfUYv4tkyfeLGwbVWK0Ju5o/44/rN2oa61N4jVR+lpgfyKvl
         LWPviXvg3+B66scr9LWqPpgoFzS80RE3J84p6On9kokW8HSoI10mBxlux+nwqOX3xX3R
         0lRdI+JxOVueksN1AmRUkEzYeoBl7lxwFoosUN+dOogN3oTPS9hlWuPuKjTWhu9XJieK
         GHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712875203; x=1713480003;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4TnsFcjuXgA9nuQRAvIeS3/zSNBm8/9BgUmS0MLmqs=;
        b=mPAlUpERUbFJbnKg/3Bc8+1x5o6qOhiRfyDz37aopu7NU5ZDdODBgc8Ihm+8svu/8B
         T+/r/ZI5wtnZXLxEHUu2jbWgUJ1gyG8+zWoeEZYFG0S1HrwlqKFejLKu27x+cHxk1a4l
         vdSZNkTzjGum92V2aTBRctq6Vr1j4duHWScK207Twqje67y8cES5sqa7ND9Wfm/STeyu
         2QijEh0LURcLJmJoIzUtIJXI/1KhkaFo5e06DMKEemBWq3wp9s8kgwL/N6h2CvEvW1k2
         rZbmNosAafqW/yLJNmONS5ZsmMw/9WyqeVy9z3XDbasu4/UQ4DHNUHrGgKJyh4JvGiWQ
         yv7w==
X-Forwarded-Encrypted: i=1; AJvYcCU/q1m+VkB7EVY9Ae09RhRCBc5ZngzxQgZCWAzAvOjMkZGtTFp0phHZQDTgKRlu3iAuUsekq4MtMi3WCmXbptgyQDks9Wc=
X-Gm-Message-State: AOJu0YyJorQ+k9ZymlKdXNX4tDwP+p9VQ+iZDvM+5KPx8m680OijiU5h
	B++5lhikVMWNSnor2ZzX/YSQG7dyAfX57FptGJyVN7KOWGqFN6beqbrETHt5yzU=
X-Google-Smtp-Source: AGHT+IGY8qJhojjfCfabFUjR9vvGK5A/WLCfM1Bk52OhJKElMImmd0eUpMrnmf84M99SmcErfv1epA==
X-Received: by 2002:ac2:57db:0:b0:513:eeaa:8f1f with SMTP id k27-20020ac257db000000b00513eeaa8f1fmr649500lfo.47.1712875203340;
        Thu, 11 Apr 2024 15:40:03 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:a470:5d20:8e1a:464a])
        by smtp.gmail.com with ESMTPSA id jx24-20020a170907761800b00a46aba003eesm1144762ejc.215.2024.04.11.15.40.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 15:40:02 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] treewide: Fix common grammar mistake "the the"
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <0bd7ccc2-4d8c-455b-a6c2-972ebe1fcb08@moroto.mountain>
Date: Fri, 12 Apr 2024 00:39:51 +0200
Cc: kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org,
 speakup@linux-speakup.org,
 intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 linux-wireless@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 linux-afs@lists.infradead.org,
 ecryptfs@vger.kernel.org,
 netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 linux-unionfs@vger.kernel.org,
 linux-arch@vger.kernel.org,
 io-uring@vger.kernel.org,
 cocci@inria.fr,
 linux-perf-users@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <193B959E-60A3-499A-BFF3-EA7B2D0B6C12@toblux.com>
References: <20240411150437.496153-4-thorsten.blum@toblux.com>
 <0bd7ccc2-4d8c-455b-a6c2-972ebe1fcb08@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 11. Apr 2024, at 17:25, Dan Carpenter <dan.carpenter@linaro.org> =
wrote:
>=20
> It's tricky to know which tree a patch like this would go through.

The patch is based on the mainline tree. Should I have sent it directly =
to
Linus then?

I'm relatively new here and therefore only sent it to the corresponding =
mailing
lists.

Thanks,
Thorsten=
