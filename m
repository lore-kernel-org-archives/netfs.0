Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC81BBBC3
	for <netfs@lists.linux.dev>; Tue,  1 Oct 2024 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727763938; cv=none; b=pmP5o35Vv8wNePSkvf1fTbM9dIPhM0UCMDVLgdqvXQ/iKnmRS3wa1IYaQGjtONRW+6i32sDC091a/VHbIOfNqLJjM2LzsZ2SVxNe5T22f6zrMXiGdy98x/K2p5Q2TFAetvHGT5y2HpzaUq66A1yg1gWqusOPLiKrroPXfsU1iPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727763938; c=relaxed/simple;
	bh=SDEAHsJ/f6Z17yj5MMAPVYkEKm1nbutbrgnE6edLQ1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpb6Ia6Vlgn1pUYQX1jxRUCMvU/7sedJKtELOElmKszlldoBITCgX9JnYho5E9JtNmZ4iBF+q6yHapTMKJTH9g+FqxoKBzQD3UurvTK3ApOhSBy2zucVpneOFluCgSfN1zo9ZOFZCdOAsSKNY5OqFSNG09tB0Tn6vWW7whgdX84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnSamiZk; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnSamiZk"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e03e9d1f8dso3135605b6e.2
        for <netfs@lists.linux.dev>; Mon, 30 Sep 2024 23:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727763936; x=1728368736; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TMTe4WCPIbVD/SfU9sxR/iUs1Fd9iOBERyBTIj/x0eQ=;
        b=NnSamiZkEwLsu5TMMLXOSzcX7WvROSHnxizTOT/HcySlrTlvylYlqUdK4HDcLM3aaI
         JlEKVtrZH5/mIegR6QHRzKisgQSns46jyYvXldoh4TYlR5kUWXjblrCRJTO66alo+/hV
         ySMkIYmOTmgDUbYtzSnG/MA18ZV1hUnTUyIwHhjf6B/kmFMzRDTU995a1VsCrt2eMM1u
         MQI5CmnO4USr1s64FSchLI3HQfWX6NkKkacA9YET0lxlfkJjHTsP+SNwMVxRzb9mRngp
         iN6Y4KVih05X4UydTog9TlIJ+zt6mGA0Yu9uxSrK1Xk/i2bGRNxv0czrL6FVZjRSWOoO
         F2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727763936; x=1728368736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMTe4WCPIbVD/SfU9sxR/iUs1Fd9iOBERyBTIj/x0eQ=;
        b=bC06ubAa0heO8TLq2g1TaEGnwXd/J84+0IRsISV8UDt0OzVS4mt4LNQB1hXOQPkuoA
         NDPG3qOFWWTRrpI+80arIbKEVdOIkJMtPF6Ak5Tlisrr5R5kikKUt8TU5uMpDmgFWDw3
         gXK9DBxrBo0jcD0XevwBXQEJy9fJUPu/V8dC7NH4ifvUOLXK/DpjXEn8yAijar9tkU/p
         Ylz39btNmQxVpnDxLwrI2ZPBb7luc2xT6Ne9xVSWyGLG3FaJRau9CX3jMY+ykD5avxRF
         XiUkOgkmFveu8JQ7UWMvRVqq0s1bShpmMKf57pTSNS552ZeeJe2hO5PUDM0/kVRNRVDf
         NngA==
X-Forwarded-Encrypted: i=1; AJvYcCXaMwGQzuEyNisJ75FODZ6b0BCfGfC+tjbK8ggWjnXbOe+3GjT2ZFhZdahGA6j5eRXtiYBz0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzpl7LK4j5PqxYZwQVPGznCyd1ZHDTwLmSc0m9FCpeeYTOtIUbw
	HxuSwTe2yJhM5PSuUeKTEl4uCJ7PpcWZVSLIhGS42pXRmUGTj3vh
X-Google-Smtp-Source: AGHT+IFuiqheCF5J619VF74VTHT4R1d7m2PaCJLI4zzhZ5KjAej0T+420gSpuHK1kgES5kwtZdo19g==
X-Received: by 2002:a05:6808:19aa:b0:3e0:4076:183b with SMTP id 5614622812f47-3e3939d402dmr12736707b6e.32.1727763935978;
        Mon, 30 Sep 2024 23:25:35 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649b0fdsm7284059b3a.40.2024.09.30.23.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:25:35 -0700 (PDT)
Date: Mon, 30 Sep 2024 23:25:33 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, jlayton@kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Fix a KMSAN uninit-value error in
 netfs_clear_buffer
Message-ID: <ZvuV3QzwrPcC6yYo@gmail.com>
References: <Zu4doSKzXfSuVipQ@gmail.com>
 <743844.1727075543@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743844.1727075543@warthog.procyon.org.uk>

On Mon, Sep 23, 2024 at 08:12:23AM +0100, David Howells wrote:
> Chang Yu <marcus.yu.56@gmail.com> wrote:
> 
> > Use kzalloc instead of kmalloc in netfs_buffer_append_folio to fix
> > a KMSAN uninit-value error in netfs_clear_buffer
> 
> Btw, is this a theoretical error or are you actually seeing an uninitialised
> pointer being dereferenced?
Apologies for the late reply. Yes this bug was reported by syzbot
(https://syzkaller.appspot.com/bug?extid=921873345a95f4dae7e9) and I was
able to reproduce it locally on my machine. I've just tested it with the
latest upstream and confirmed that the bug is still present. I will
send a revised patch shortly, please feel free to take a look.

Chang

