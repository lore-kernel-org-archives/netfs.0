Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450835941
	for <netfs@lists.linux.dev>; Mon,  9 Dec 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751090; cv=none; b=n+AfN0we0rJRJrd0JYNqZqTp3BzjrQbVv+05B4LavpYXdHBYmtrFn2MS6R6NkmfeVWa/3Vk99smmGD0A7+MUjSJF/W+UWG/r3yerbk5/e/RSwCBfEUe46Ko+v9qVdfu9ttlAePIpqDaR+fRqbDnF6rS9g69Wti3QoIsvbyetDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751090; c=relaxed/simple;
	bh=ftTBkUoM2LcsGeAp9168BTi0yYIu6Ei50+DC8gomF3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO/PlmDBy0oJNAaXD1IUBF2TTMFV2sVPV95la1z/4tR/A1PUzoYKD6WcZgnND1muaZ4Qo+F9rlojWNbdh466IkrGpf22AGQR2wOanzDH3iDjvDsU65xVdpVYbG3wqhyWWuVJixqcXUE3+8WxcCHbEIxqzEH+IuXWLx+RsA+kcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DulWbCS6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DulWbCS6"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa6997f33e4so59421066b.3
        for <netfs@lists.linux.dev>; Mon, 09 Dec 2024 05:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733751085; x=1734355885; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftTBkUoM2LcsGeAp9168BTi0yYIu6Ei50+DC8gomF3g=;
        b=DulWbCS6h/Q8hlPQ+gJ63VRqffMpzzv1zVpIA9FPm2QEw4SzGESkOvTvIY5tJTq3+l
         U1zG/kMCIiBRvyAwov+HThYEp2XrsAKe/m1r47Xc8A4jjv68WU/qYyvnoi1EZDSxPoBb
         J6AlOebzBZ7bnKSZ2vdAaYm+1Ms9Wx1v7KVPZfSy0tOqWVIyI7SelYq8Ytl8BfPXe1XU
         YvnfW1/aTMIyHsY2ui9oicPdbFcYgwo9M82eS+8gRco6XP6BnkIFfIBxqFmnu6dOh92x
         OHaFw0iNkyJB7tkfyga3P1ZdMuQq8vOOpj+VUqry8ZNujw3ZBi1MY8IxpA3X3UgbPuBj
         mQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751085; x=1734355885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftTBkUoM2LcsGeAp9168BTi0yYIu6Ei50+DC8gomF3g=;
        b=iBFKdX1HyrXoFuD+10oG5YYD5pkjahDurPoud2SNR8HAJ+7aZHJQEVKO+XF6eC1SNW
         rwr2L1WtYaepLHFBa1t4zwmh73YL4DSHeBXcRPh4WDBiCF21uk4Sk+IZDxuTqx0DJbTN
         mtsXPZLL3m94t7kF78P2FCXJWr9cvt03oVitqF01Sf/64hbjZPVsMkKXCXpxRfY1boIf
         9y8Rr1GaTEa1uj+h+1ZdvBGxs8OxGb0DeEVoZc+yrfPXrFIQd+509Blx23N/WCQyzhn2
         Q9i1X/zOCXs2ycAr7oL9omOVRM0LgF7UAocLdkh6iy2yEOEBiBVs3S0Z3iscsODsiYEO
         tA2g==
X-Forwarded-Encrypted: i=1; AJvYcCUFztbq6nedFY3w72DCDSBQcYJQSAnU+bb+7sIyk0A47gVmcT5F5tDGpwI3i+m1OlDD/ilINg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXk4Zu7o8zg+JjVW3/Kil5Kra03vCWm9vLAHOmlQl85+T8agqe
	M6L8PZ9FBkQnmyl4G8F1CUTqBI2xDVbK71J1FZhYiYo+C50RmoUFR+4ZIHb9+55L5ebsYEGmyHd
	8CjZdcDmMAY9BVJgH+1i1do9nGisj2h/TRkaElg==
X-Gm-Gg: ASbGncsInaosEtSh82EXced0qiGSpDDqm8KrhNJMAB63qAfNoN0Iv7+496FgH3uoZ9Z
	KFrFnUnhsICSBd68ioVMzQv2Uske/NHUijh9FqVkItrG7VGgOEQYgkOOg1yM4
X-Google-Smtp-Source: AGHT+IEmztFz48a0t6/WSmXctJ2wrGWImd2oFKYKo2f4N5KU2N5Ux6YRxIOaj/ZsHQRzkCXMX15Wbqnx3MAscmomOG4=
X-Received: by 2002:a17:907:9518:b0:aa6:7662:c56e with SMTP id
 a640c23a62f3a-aa67662d783mr557411466b.55.1733751085028; Mon, 09 Dec 2024
 05:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
 <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
 <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com>
 <1995560.1733519609@warthog.procyon.org.uk> <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com>
 <CAKPOu+-h2B0mw0k_XiHJ1u69draDLTLqJhRmr3ksk2-ozzXiTg@mail.gmail.com> <2117977.1733750054@warthog.procyon.org.uk>
In-Reply-To: <2117977.1733750054@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 9 Dec 2024 14:31:14 +0100
Message-ID: <CAKPOu+-Bpds7-Ocb-tBMs1==YzVhhx01+FaiokiGR3A-W9t_gQ@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix ceph copy to cache on write-begin
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 2:14=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> Could you try this?

No change, still hangs immediately on the first try.
